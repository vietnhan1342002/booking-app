const Reviews = require("../model/reviewModel");
const Hotels = require("../model/hotelModel");
const Users = require("../model/userModel");
const checkReviewOwnership = require("../../middleware/checkReivewOwnerShip");

class UserController {
  async readReview(req, res) {
    try {
      const reviewList = await Reviews.find().populate("user_id");
      res.status(200).json(reviewList);
    } catch (err) {
      res.status(500).json({ error: err });
    }
  }

  async createReview(req, res) {
    try {
      const { comment, rating } = req.body;
      const hotelId = req.params.hotelId;
      const userId = req.body.user_id || req.user.userId;
      // Lấy id của người dùng từ request

      // Kiểm tra xem khách sạn có tồn tại không
      const hotel = await Hotels.findById(hotelId);
      if (!hotel) {
        return res.status(404).json({ message: "Không tìm thấy khách sạn" });
      }

      // Tạo review và liên kết với người dùng và khách sạn
      const review = new Reviews({
        comment,
        rating,
        user_id: userId,
      });

      const newReview = await review.save();

      // Liên kết review với khách sạn
      hotel.reviews.push(newReview._id);
      await hotel.save();

      // Liên kết review với người dùng
      const user = await Users.findById(userId);
      if (user) {
        user.reviews.push(newReview._id);
        await user.save();
      }
      console.log("req.user.userId:", userId);
      res.status(201).json({ review: newReview });
    } catch (error) {
      console.error(error);
      console.log("req.user:", req.user);
      console.log("req.user._id:", req.user ? req.user._id : "undefined");
      res.status(500).json({ message: "Internal server error" });
    }
  }

  async updateReview(req, res) {
    checkReviewOwnership(req, res, async () => {
      try {
        const reviewIdToUpdate = req.params.reviewId;
        const { comment, rating } = req.body;

        // Cập nhật đánh giá trong Reviews collection
        const updatedReview = await Reviews.findByIdAndUpdate(
          reviewIdToUpdate,
          { comment, rating },
          { new: true }
        );

        if (!updatedReview) {
          return res.status(404).json({ message: "Không tìm thấy đánh giá." });
        }

        // Cập nhật đánh giá trong User collection
        await Users.updateOne(
          { reviews: reviewIdToUpdate },
          { $set: { "reviews.$": updatedReview._id } }
        );

        // Cập nhật đánh giá trong Hotel collection
        await Hotels.updateOne(
          { reviews: reviewIdToUpdate },
          { $set: { "reviews.$": updatedReview._id } }
        );

        res
          .status(200)
          .json({ message: "Đánh giá đã được cập nhật thành công." });
      } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Lỗi nội bộ của máy chủ." });
      }
    });
  }

  async deleteReview(req, res) {
    try {
      const reviewId = req.params.reviewId;
      const userIdFromUser = req.user.userId;

      const review = await Reviews.findById(reviewId);

      if (!review) {
        return res.status(404).json({ message: "Đánh giá không tồn tại." });
      }

      // logic này đang sai, ngủ dậy sửa lại
      if (review.user_id.toString() !== userIdFromUser.toString()) {
        return res
          .status(403)
          .json({ message: "Bạn không có quyền thực hiện thao tác này." });
      }

      const reviewIdToDelete = req.params.reviewId;

      // Xóa đánh giá từ Reviews collection
      await Reviews.findByIdAndDelete(reviewIdToDelete);

      // Cập nhật mảng reviews trong User collection
      await Users.updateOne(
        { reviews: reviewIdToDelete },
        { $pull: { reviews: reviewIdToDelete } }
      );

      // Cập nhật mảng reviews trong Hotel collection
      await Hotels.updateOne(
        { reviews: reviewIdToDelete },
        { $pull: { reviews: reviewIdToDelete } }
      );
      console.log(review);
      res.status(200).json({ message: "Đánh giá đã được xóa thành công." });
    } catch (error) {
      console.error(error);
      console.log(req.user.userId);
      res.status(500).json({ message: "Lỗi nội bộ của máy chủ." });
    }
  }
}

module.exports = new UserController();

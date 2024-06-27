// middleware/checkReviewOwnership.js
const Reviews = require("../app/model/reviewModel");

const checkReviewOwnership = async (req, res, next) => {
  try {
    const reviewId = req.params.reviewId;
    const userId = req.body.user_id || req.user._id;

    const review = await Reviews.findById(reviewId);

    if (!review) {
      return res.status(404).json({ message: "Đánh giá không tồn tại." });
    }

    // Kiểm tra xem người dùng hiện tại có quyền sở hữu đánh giá không
    if (review.user.toString() !== userId.toString()) {
      return res
        .status(403)
        .json({ message: "Bạn không có quyền thực hiện thao tác này." });
    }

    // Truyền kiểm tra thành công, chuyển sang controller tiếp theo
    next();
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Lỗi nội bộ của máy chủ." });
  }
};

module.exports = checkReviewOwnership;

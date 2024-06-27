// const jwt = require("jsonwebtoken");
const Hotels = require("../model/hotelModel");
const Rooms = require("../model/roomModel");
const Admins = require("../model/adminModel");
const fs = require("fs");
const path = require("path");

class HotelController {
  async readHotel(req, res) {
    try {
      const hotelList = await Hotels.find()
        .populate({
          path: "reviews",
          populate: {
            path: "user_id", // Tên trường chứa id của người dùng trong reviews
            model: "User", // Tên model của người dùng
          },
        })
        .populate("rooms");
      res.status(200).json(hotelList);
    } catch (err) {
      res.status(500).json({ error: err });
    }
  }

  async createHotel(req, res) {
    try {
      const { name, address, desc, nearby, contact, amenities } = req.body;
      const adminId = req.admin.adminId;
      // Lấy id của người dùng từ request

      // Kiểm tra xem admin có tồn tại không
      const admin = await Admins.findById(adminId);
      if (!admin) {
        return res
          .status(404)
          .json({ message: "Không tìm thấy tài khoản này" });
      }

      const images = req.files.map((file) => ({
        url: file.path,
        public_id: file.filename,
      }));

      const hotel = new Hotels({
        name,
        address,
        desc,
        nearby,
        contact,
        amenities: JSON.parse(amenities),
        images,
      });

      const newHotel = await hotel.save();
      // Liên kết hotel với admin
      admin.hotel.push(newHotel._id);
      await admin.save();
      res.status(201).json({ hotel: newHotel });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Internal server error" });
    }
  }

  async selectHotel(req, res) {
    const hotelId = req.params.hotelId;
    try {
      const hotel = await Hotels.findById(hotelId);
      if (!hotel) {
        return res.status(404).json({ message: "Không tìm thấy khách sạn" });
      }
      res.status(200).json(hotel);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  }

  async updateHotel(req, res) {
    try {
      const { name, address, desc, nearby, contact, amenities } = req.body;

      const images = req.files.map((file) => ({
        url: file.path,
        public_id: file.filename,
      }));

      const hotel = await Hotels.findById(req.params.hotelId);

      if (!hotel) {
        return res.status(404).json({ message: "Hotel not found" });
      }

      hotel.name = name;
      hotel.address = address;
      hotel.desc = desc;
      hotel.nearby = nearby;
      hotel.contact = contact;
      hotel.amenities = JSON.parse(amenities);
      hotel.images = images;

      const updatedHotel = await hotel.save();
      res.json({ room: updatedHotel });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Internal server error" });
    }
  }

  async deleteHotel(req, res) {
    const hotelId = req.params.hotelId;

    try {
      // Tìm và xóa khách sạn
      const hotel = await Hotels.findById(hotelId);
      if (!hotel) {
        return res.status(404).json({ message: "Khách sạn không tồn tại" });
      }

      // Lấy danh sách các phòng của khách sạn
      const roomIds = hotel.rooms;

      // Xóa khách sạn
      const deletedHotel = await Hotels.findOneAndDelete({ _id: hotelId });

      if (!deletedHotel) {
        return res
          .status(404)
          .json({ message: `Khách sạn không tồn tại ${hotelId}` });
      }

      // Nếu có phòng, xóa các phòng tương ứng
      if (roomIds.length > 0) {
        await Rooms.deleteMany({ _id: { $in: roomIds } });
      }

      // Cập nhật mảng reviews trong User collection
      await Admins.updateOne({ hotel: hotelId }, { $pull: { hotel: hotelId } });

      // Tiến hành xóa ảnh từ thư mục public/uploads nếu có
      const imageName = hotel.images && hotel.images[0].public_id;
      if (imageName) {
        const imagePath = path.join(
          "D:/Project/Flutter/booking_app/assets/uploads",
          imageName
        );
        fs.unlinkSync(imagePath);
      }

      res.json({ message: "Xoá khách sạn và các phòng thành công" });
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "Lỗi server" });
    }
  }

  async roomList(req, res) {
    const hotelId = req.params.hotelId;

    try {
      const hotel = await Hotels.findById(hotelId).populate("rooms");

      if (!hotel) {
        return res.status(404).json({ message: "Không tìm thấy khách sạn." });
      }

      res.json(hotel.rooms);
    } catch (error) {
      console.error("Lỗi khi lấy danh sách phòng khách sạn:", error);
      res.status(500).json({ message: "Lỗi server" });
    }
  }
}

module.exports = new HotelController();

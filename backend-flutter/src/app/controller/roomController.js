const Rooms = require("../model/roomModel");
const Hotels = require("../model/hotelModel");
const fs = require("fs");
const path = require("path");

class RoomController {
  async readRoom(req, res) {
    try {
      const roomList = await Rooms.find();
      res.status(200).json(roomList);
    } catch (err) {
      res.status(500).json({ error: err });
    }
  }

  async createRoom(req, res) {
    try {
      const {
        numRoom,
        priceRoom,
        typeRoom,
        statusRoom,
        numGuestRoom,
        bedRoom,
      } = req.body;
      const hotelId = req.params.hotelId;

      const hotel = await Hotels.findById(hotelId);
      if (!hotel) {
        return res.status(404).json({ message: "Không tìm thấy khách sạn" });
      }

      const imageRoom = {
        url: req.file ? req.file.path : "",
        public_id: req.file ? req.file.filename : "",
      };

      const room = new Rooms({
        numRoom,
        priceRoom,
        typeRoom,
        statusRoom,
        numGuestRoom,
        bedRoom,
        imageRoom,
      });

      const newRoom = await room.save();
      // Liên kết review với khách sạn
      hotel.rooms.push(newRoom._id);
      await hotel.save();
      res.status(201).json({ room: newRoom });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Internal server error" });
    }
  }

  async updateRoom(req, res) {
    try {
      const { priceRoom, typeRoom, statusRoom, numGuestRoom, bedRoom } =
        req.body;

      const imageRoom = {
        url: req.file ? req.file.path : "",
        public_id: req.file ? req.file.filename : "",
      };

      const room = await Rooms.findById(req.params._id);

      if (!room) {
        return res.status(404).json({ message: "Room not found" });
      }

      room.priceRoom = priceRoom;
      room.typeRoom = typeRoom;
      room.statusRoom = statusRoom;
      room.bedRoom = bedRoom;
      room.numGuestRoom = numGuestRoom;
      room.imageRoom = imageRoom;

      const updatedRoom = await room.save();
      res.json({ room: updatedRoom });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Internal server error" });
    }
  }

  async deleteRoom(req, res) {
    try {
      const { roomId } = req.params;
      // Tìm phòng theo ID
      const room = await Rooms.findById(roomId);
      if (!room) {
        return res.status(404).json({ message: "Phòng không tồn tại1" });
      }

      // Lấy tên tệp ảnh từ thông tin phòng
      const imageName = room.imageRoom && room.imageRoom.public_id;

      // Xóa phòng
      const deletedRoom = await Rooms.findByIdAndDelete(roomId);

      if (!deletedRoom) {
        return res.status(404).json({ message: "Phòng không tồn tại" });
      }

      // Xóa ảnh từ thư mục public/uploads nếu có tên tệp ảnh
      if (imageName) {
        const imagePath = path.join(
          "D:/Project/Flutter/booking_app/assets/uploads",
          imageName
        );
        fs.unlinkSync(imagePath);
      }
      res.json({ message: "Xoá phòng thành công" });
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "Lỗi server" });
    }
  }

  async selectRoom(req, res) {
    try {
      const roomId = req.params._id;
      const room = await Rooms.findById(roomId);
      if (!room) {
        return res.status(404).json({ message: "Không tìm thấy phòng" });
      }
      res.status(200).json(room);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  }
}

module.exports = new RoomController();

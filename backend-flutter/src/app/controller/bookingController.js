// const jwt = require("jsonwebtoken");
const Bookings = require("../model/bookingModel");
const Hotels = require("../model/hotelModel");
const Users = require("../model/userModel");

class BookingController {
  async readBooking(req, res) {
    try {
      const bookingList = await Bookings.find();
      res.status(200).json(bookingList);
    } catch (err) {
      res.status(500).json({ error: err });
    }
  }

  async createBooking(req, res) {
    try {
      const {
        fullname,
        room,
        phone,
        email,
        guest,
        quantity,
        checkin,
        checkout,
        total,
      } = req.body;
      const hotelId = req.params.hotelId;
      const userId = req.body.user_id || req.user.userId;
      console.log(userId);

      const hotel = await Hotels.findById(hotelId);
      if (!hotel) {
        return res.status(404).json({ message: "Không tìm thấy khách sạn" });
      }

      const booking = new Bookings({
        user_id: userId,
        fullname,
        room,
        phone,
        email,
        guest,
        quantity,
        checkin,
        checkout,
        total,
      });

      const newBooking = await booking.save();
      hotel.booking.push(newBooking._id);
      await hotel.save();
      const user = await Users.findById(userId);
      if (user) {
        user.booking.push(newBooking._id);
        await user.save();
      }
      res.status(201).json({ booking: newBooking });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Internal server error" });
    }
  }

  async deleteBooking(req, res) {
    try {
      const bookingIdToDelete = req.params.bookingId;
      console.log(bookingId);

      await Bookings.findByIdAndDelete(bookingIdToDelete);

      await Users.updateOne(
        { booking: bookingIdToDelete },
        { $pull: { booking: bookingIdToDelete } }
      );

      await Hotels.updateOne(
        { booking: bookingIdToDelete },
        { $pull: { booking: bookingIdToDelete } }
      );

      res.status(200).json({ message: "Đơn đặt đã được xóa thành công." });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Lỗi nội bộ của máy chủ." });
    }
  }
}

module.exports = new BookingController();

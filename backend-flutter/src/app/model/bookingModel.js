const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const bookingSchema = new Schema(
  {
    user_id: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
    fullname: { type: String, required: true },
    room: { type: String, required: true },
    phone: { type: Number, required: true },
    email: { type: String, required: true },
    guest: { type: Number, required: true },
    quantity: { type: Number, required: true },
    checkin: { type: Date, required: true },
    checkout: { type: Date, required: true },
    total: { type: Number, required: true },
    status: {
      type: String,
      default: "Chưa xác nhận",
      enum: ["Chưa xác nhận", "Đã xác nhận"],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Booking", bookingSchema);

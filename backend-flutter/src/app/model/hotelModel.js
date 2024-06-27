const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const hotelSchema = new Schema(
  {
    name: { type: String, required: true, unique: true },
    address: { type: String, required: true },
    reviews: [{ type: Schema.Types.ObjectId, ref: "Review" }],
    desc: { type: String, required: true },
    nearby: { type: Number, required: true },
    contact: { type: String, required: true },
    amenities: { type: [String], required: true },
    rooms: [{ type: Schema.Types.ObjectId, ref: "Room" }],
    booking: [{ type: Schema.Types.ObjectId, ref: "Booking" }],
    images: [
      {
        type: {
          url: { type: String },
          public_id: { type: String },
        },
      },
    ],
  },
  { timestamps: true }
);

module.exports = mongoose.model("Hotel", hotelSchema);

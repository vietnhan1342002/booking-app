const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const roomSchema = new Schema(
  {
    numRoom: { type: Number, required: true },
    priceRoom: { type: Number, required: true },
    typeRoom: { type: String, required: true },
    statusRoom: { type: Number, required: true },
    numGuestRoom: { type: Number, required: true },
    bedRoom: { type: String, required: true },
    imageRoom: {
      type: Object,
      url: { type: URL },
      public_id: { type: String },
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Room", roomSchema);

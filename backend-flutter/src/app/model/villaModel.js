const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const villaSchema = new Schema(
  {
    nameVilla: { type: String, required: true, unique: true },
    addressVilla: { type: String, required: true, unique: true },
    priceVilla: { type: Number, required: true, unique: true },
    ratingVilla:  { type: Number, required: true, unique: true },
    reviewVilla: { type: String, required: true, unique: true },
    descVilla: { type: String, required: true, unique: true },
    nearbyVilla: { type: Number, required: true, unique: true },
    contactVilla: { type: String, required: true, unique: true },
    imageVilla: {
      type: Object,
      url: { type: URL },
      public_id: { type: String }
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Villa", villaSchema);

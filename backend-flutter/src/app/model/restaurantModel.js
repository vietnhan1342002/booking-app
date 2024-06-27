const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const restaurantSchema = new Schema(
  {
    nameRestaurant: { type: String, required: true, unique: true },
    addressRestaurant: { type: String, required: true, unique: true },
    ratingRestaurant : { type: String, required: true, unique: true },
    typeRestaurant: { type: String, required: true, unique: true },
    contactRestaurant: { type: String, required: true, unique: true },
    statusRestaurant: { 
        type: Object,
        open: { type: String},
        close: { type: String } 
    },
    imageRestaurant: {
        type: Object,
        url: { type: URL },
        public_id: { type: String }
      },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Restaurant", restaurantSchema);

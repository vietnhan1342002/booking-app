const express = require("express");
const router = express.Router();
const env = require("../config/env");
const upload = require("../middleware/multer");
const authenticateTokenAdmin = require("../middleware/authenticateAdmin");

const hotelController = require("../app/controller/hotelController");

router.get(env.HOTEL_READ, hotelController.readHotel);
router.get(env.HOTEL_ROOMS, hotelController.roomList);
router.get(env.HOTEL_SELECT, hotelController.selectHotel);
router.delete(
  env.HOTEL_DELETE,
  authenticateTokenAdmin,
  hotelController.deleteHotel
);
router.post(
  env.HOTEL_CREATE,
  authenticateTokenAdmin,
  upload.array("images", 10),
  hotelController.createHotel
);
router.put(
  env.HOTEL_UPDATE,
  authenticateTokenAdmin,
  upload.array("images", 10),
  hotelController.updateHotel
);

module.exports = router;

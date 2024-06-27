const express = require("express");
const router = express.Router();
const env = require("../config/env");

const bookingController = require("../app/controller/bookingController");

router.get(env.BOOKING_READ, bookingController.readBooking);
router.post(env.BOOKING_CREATE, bookingController.createBooking);
router.delete(env.BOOKING_DELETE, bookingController.deleteBooking);

module.exports = router;

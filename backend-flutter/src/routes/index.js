const userRouter = require("./user");
const adminRouter = require("./admin");
const hotelRouter = require("./hotel");
const roomRouter = require("./room");
const reviewRouter = require("./review");
const bookingRouter = require("./booking");
const env = require("../config/env");

function route(app) {
  app.use(env.API_USERS, userRouter);
  app.use(env.API_ADMINS, adminRouter);
  app.use(env.API_HOTELS, hotelRouter);
  app.use(env.API_ROOMS, roomRouter);
  app.use(env.API_REVIEW, reviewRouter);
  app.use(env.API_BOOKING, bookingRouter);
  app.all("*", (req, res) => res.send("That route doesn't exist"));
}

module.exports = route;

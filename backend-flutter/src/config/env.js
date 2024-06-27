require("dotenv").config();

const env = {
  DB_URL: process.env.DB_URL,
  PORT: process.env.PORT,
  // API người dùng
  API_USERS: process.env.API_USERS,
  USER_READ: process.env.USER_READ,
  USER_REGISTER: process.env.USER_REGISTER,
  USER_LOGIN: process.env.USER_LOGIN,
  USER_LOGOUT: process.env.USER_LOGOUT,
  JWT_SECRET: process.env.JWT_SECRET,
  UPDATE_ROLE: process.env.UPDATE_ROLE,

  // API admin
  API_ADMINS: process.env.API_ADMINS,
  ADMIN_READ: process.env.ADMIN_READ,
  ADMIN_REGISTER: process.env.ADMIN_REGISTER,
  ADMIN_LOGIN: process.env.ADMIN_LOGIN,
  ADMIN_LOGOUT: process.env.ADMIN_LOGOUT,
  ADMIN_SELECT: process.env.ADMIN_SELECT,
  JWT_SECRET_ADMIN: process.env.JWT_SECRET_ADMIN,
  UPDATE_ROLE_ADMIN: process.env.UPDATE_ROLE,

  // API Khách sạn
  API_HOTELS: process.env.API_HOTELS,
  HOTEL_READ: process.env.HOTEL_READ,
  HOTEL_CREATE: process.env.HOTEL_CREATE,
  HOTEL_UPDATE: process.env.HOTEL_UPDATE,
  HOTEL_DELETE: process.env.HOTEL_DELETE,
  HOTEL_ROOMS: process.env.HOTEL_ROOMS,
  HOTEL_SELECT: process.env.HOTEL_SELECT,

  // API phòng
  API_ROOMS: process.env.API_ROOMS,
  ROOM_READ: process.env.ROOM_READ,
  ROOM_CREATE: process.env.ROOM_CREATE,
  ROOM_UPDATE: process.env.ROOM_UPDATE,
  ROOM_DELETE: process.env.ROOM_DELETE,
  ROOM_SELECT: process.env.ROOM_SELECT,

  // API Review
  API_REVIEW: process.env.API_REVIEW,
  REVIEW_READ: process.env.REVIEW_READ,
  REVIEW_CREATE: process.env.REVIEW_CREATE,
  REVIEW_UPDATE: process.env.REVIEW_UPDATE,
  REVIEW_DELETE: process.env.REVIEW_DELETE,

  // API Booking
  API_BOOKING: process.env.API_BOOKING,
  BOOKING_READ: process.env.BOOKING_READ,
  BOOKING_CREATE: process.env.BOOKING_CREATE,
  BOOKING_DELETE: process.env.BOOKING_DELETE,
};

module.exports = env;

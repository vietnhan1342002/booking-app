const express = require("express");
const router = express.Router();
const env = require("../config/env");

const userController = require("../app/controller/userController");

router.get(env.USER_READ, userController.readUser);
router.post(env.USER_REGISTER, userController.registerUser);
router.post(env.USER_LOGIN, userController.loginUser);
router.post(env.USER_LOGOUT, userController.logoutUser);
router.put(env.UPDATE_ROLE, userController.updateRole);

module.exports = router;

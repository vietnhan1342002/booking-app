const express = require("express");
const router = express.Router();
const env = require("../config/env");

const adminController = require("../app/controller/adminController");

router.get(env.ADMIN_READ, adminController.readAdmin);
router.get(env.ADMIN_SELECT, adminController.selectAdmin);
router.post(env.ADMIN_REGISTER, adminController.registerAdmin);
router.post(env.ADMIN_LOGIN, adminController.loginAdmin);
router.post(env.ADMIN_LOGOUT, adminController.logoutAdmin);
router.put(env.UPDATE_ROLE_ADMIN, adminController.updateRoleAdmin);

module.exports = router;

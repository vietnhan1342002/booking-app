const express = require("express");
const router = express.Router();
const env = require("../config/env");
const upload = require("../middleware/multer");

const roomController = require("../app/controller/roomController");

router.get(env.ROOM_READ, roomController.readRoom);
router.post(
  env.ROOM_CREATE,
  upload.single("imageRoom"),
  roomController.createRoom
);
router.put(
  env.ROOM_UPDATE,
  upload.single("imageRoom"),
  roomController.updateRoom
);
router.delete(env.ROOM_DELETE, roomController.deleteRoom);
router.get(env.ROOM_SELECT, roomController.selectRoom);

module.exports = router;

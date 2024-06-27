const express = require("express");
const router = express.Router();
const env = require("../config/env");
const authenticateToken = require("../middleware/authenticateUser");

const reviewController = require("../app/controller/reviewController");

router.use(authenticateToken);

router.get(env.REVIEW_READ, reviewController.readReview);
router.post(env.REVIEW_CREATE, reviewController.createReview);
router.put(env.REVIEW_UPDATE, reviewController.updateReview);
router.delete(env.REVIEW_DELETE, reviewController.deleteReview);

module.exports = router;

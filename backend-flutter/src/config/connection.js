const mongoose = require("mongoose");
const env = require("./env");

async function connect() {
  try {
    await mongoose.connect(env.DB_URL);
    console.log("Connected to MongoDB successfully");
  } catch (error) {
    console.log("Connection to MongoDB failed", error.message);
  }
}

module.exports = { connect };

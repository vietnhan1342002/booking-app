const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const adminSchema = new Schema(
  {
    fullname: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    role: { type: String, default: "partner", enum: ["partner", "admin"] },
    hotel: [{ type: Schema.Types.ObjectId, ref: "Hotel" }],
  },
  { timestamps: true }
);

module.exports = mongoose.model("Admin", adminSchema);

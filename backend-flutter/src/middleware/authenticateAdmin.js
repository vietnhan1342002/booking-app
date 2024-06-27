const jwt = require("jsonwebtoken");
const Admins = require("../app/model/adminModel");

const authenticateTokenAdmin = async (req, res, next) => {
  try {
    const authorizationHeader = req.headers["authorization"];
    if (!authorizationHeader) {
      return res.sendStatus(401); // Unauthorized
    }

    const token = authorizationHeader.split(" ")[1];
    if (!token) {
      return res.sendStatus(401); // Unauthorized
    }

    jwt.verify(token, process.env.JWT_SECRET_ADMIN, async (err, decoded) => {
      if (err) {
        console.error(err);
        return res.sendStatus(403); // Forbidden
      }

      // Đọc thông tin người dùng từ cơ sở dữ liệu
      const admin = await Admins.findById(decoded.adminId);

      if (!admin) {
        return res.sendStatus(401); // Unauthorized
      }

      // Gán thông tin người dùng vào req để sử dụng trong các controller tiếp theo
      req.admin = {
        adminId: admin._id,
        role: admin.role,
        fullname: admin.fullname,
      };
      console.log("Admin logged in:", req.admin.adminId);

      next();
    });
  } catch (error) {
    console.error(error);
    res.sendStatus(500); // Internal Server Error
  }
};

module.exports = authenticateTokenAdmin;

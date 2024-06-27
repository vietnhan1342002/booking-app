const jwt = require("jsonwebtoken");
const Users = require("../app/model/userModel");

const authenticateToken = async (req, res, next) => {
  try {
    const authorizationHeader = req.headers["authorization"];
    if (!authorizationHeader) {
      return res.sendStatus(401); // Unauthorized
    }

    const token = authorizationHeader.split(" ")[1];
    if (!token) {
      return res.sendStatus(401); // Unauthorized
    }

    jwt.verify(token, process.env.JWT_SECRET, async (err, decoded) => {
      if (err) {
        console.error(err);
        return res.sendStatus(403); // Forbidden
      }

      // Đọc thông tin người dùng từ cơ sở dữ liệu
      const user = await Users.findById(decoded.userId);

      if (!user) {
        return res.sendStatus(401); // Unauthorized
      }

      // Gán thông tin người dùng vào req để sử dụng trong các controller tiếp theo
      req.user = { userId: user._id, role: user.role, fullname: user.fullname };
      console.log("User logged in:", req.user.userId);

      next();
    });
  } catch (error) {
    console.error(error);
    res.sendStatus(500); // Internal Server Error
  }
};

module.exports = authenticateToken;

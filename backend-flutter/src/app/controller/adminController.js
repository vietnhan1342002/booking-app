const jwt = require("jsonwebtoken");
const Admins = require("../model/adminModel");

class AdminController {
  async readAdmin(req, res) {
    try {
      const adminList = await Admins.find().populate("hotel");
      res.status(200).json(adminList);
    } catch (err) {
      res.status(500).json({ error: err });
    }
  }

  async registerAdmin(req, res) {
    const { fullname, email, password } = req.body;

    // Kiểm tra xem email đã được sử dụng chưa
    const existingUser = await Admins.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "Email đã được sử dụng" });
    }

    // Tạo một đối tượng User mới và lưu nó vào cơ sở dữ liệu
    const admin = new Admins({ fullname, email, password });
    await admin.save();

    res.status(201).json({ admin });
  }

  async loginAdmin(req, res) {
    const { email, password } = req.body;

    // Tìm kiếm một đối tượng User với email trùng với email đăng nhập
    const admin = await Admins.findOne({ email });

    // Kiểm tra xem user tồn tại hay không
    if (!admin) {
      return res
        .status(401)
        .json({ message: "Email hoặc mật khẩu không đúng1" });
    }

    // So sánh password được nhập vào với password lưu trữ trong cơ sở dữ liệu
    if (password !== admin.password) {
      return res
        .status(401)
        .json({ message: "Email hoặc mật khẩu không đúng" });
    }

    // Nếu email và password hợp lệ, tạo một mã thông báo JSON và gửi về cho client-side
    const token = jwt.sign(
      { adminId: admin._id },
      process.env.JWT_SECRET_ADMIN
    );
    console.log(token);
    res.json({ admin, token });
  }

  async updateRoleAdmin(req, res) {
    try {
      const { role } = req.body;
      const admin = await Admins.findById(req.params._id);
      if (!admin) {
        return res.status(404).json({ message: "User not found" });
      }
      admin.role = role;
      const updatedRole = await admin.save();
      res.json({ admin: updatedRole });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Internal server error" });
    }
  }

  async logoutAdmin(req, res) {
    try {
      const logout = await res.clearCookie("jwt");
      console.log(`Đã xóa: ${logout}`);
      res.json({ message: "Đã đăng xuất" });
    } catch (error) {
      res.json({ error: "Lỗi khi đăng xuất" });
    }
  }

  async selectAdmin(req, res) {
    const adminId = req.params.adminId;
    try {
      const admin = await Admins.findById(adminId).populate("hotel");
      if (!admin) {
        return res
          .status(404)
          .json({ message: "Không tìm thấy tài khoản này" });
      }
      res.status(200).json(admin);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  }
}

module.exports = new AdminController();

const jwt = require("jsonwebtoken");
const Users = require("../model/userModel");

class UserController {
  async readUser(req, res) {
    try {
      const userList = await Users.find();
      res.status(200).json(userList);
    } catch (err) {
      res.status(500).json({ error: err });
    }
  }

  async registerUser(req, res) {
    const { fullname, email, password } = req.body;

    // Kiểm tra xem email đã được sử dụng chưa
    const existingUser = await Users.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "Email đã được sử dụng" });
    }

    // Tạo một đối tượng User mới và lưu nó vào cơ sở dữ liệu
    const user = new Users({ fullname, email, password });
    await user.save();

    res.status(201).json({ user });
  }

  async loginUser(req, res) {
    const { email, password } = req.body;

    // Tìm kiếm một đối tượng User với email trùng với email đăng nhập
    const user = await Users.findOne({ email });

    // Kiểm tra xem user tồn tại hay không
    if (!user) {
      return res
        .status(401)
        .json({ message: "Email hoặc mật khẩu không đúng1" });
    }

    // So sánh password được nhập vào với password lưu trữ trong cơ sở dữ liệu
    if (password !== user.password) {
      return res
        .status(401)
        .json({ message: "Email hoặc mật khẩu không đúng" });
    }

    // Nếu email và password hợp lệ, tạo một mã thông báo JSON và gửi về cho client-side
    const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET);
    console.log(token);
    res.json({ user, token });
  }

  async updateRole(req, res) {
    try {
      const { role } = req.body;
      const user = await Users.findById(req.params._id);
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
      user.role = role;
      const updatedRole = await user.save();
      res.json({ user: updatedRole });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Internal server error" });
    }
  }

  async logoutUser(req, res) {
    try {
      const logout = await res.clearCookie("jwt");
      console.log(`Đã xóa: ${logout}`);
      res.json({ message: "Đã đăng xuất" });
    } catch (error) {
      res.json({ error: "Lỗi khi đăng xuất" });
    }
  }
}

module.exports = new UserController();

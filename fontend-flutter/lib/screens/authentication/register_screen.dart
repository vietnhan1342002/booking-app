import 'dart:convert';
import 'package:booking_app/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  bool rememberMe = false;
  final Logger logger = Logger();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void registerUser() async {
    try {
      final result = await ApiService.registerUser(
        _emailController.text,
        _fullnameController.text,
        _passwordController.text,
      );

      if (result['success']) {
        // Đăng ký thành công, xử lý tương ứng
        logger.i('Đăng ký thành công');
      } else {
        // Đăng ký không thành công, xử lý tương ứng
        logger.e('Đăng ký không thành công: ${result['error']['message']}');
      }
    } catch (error) {
      // Xử lý lỗi khi gửi yêu cầu HTTP
      logger.e('Lỗi khi gửi yêu cầu đăng ký: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: IconButton(
              icon: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Color(0xffE5E5E5),
                  shape: BoxShape.circle,
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Đăng ký',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Đăng ký tài khoản của bạn',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 56,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffF8F9FA),
                      prefixIcon: const Icon(Typicons.mail),
                      labelStyle: const TextStyle(
                          color: Color(0xffADADAD),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      labelText: 'Gmail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffE5E5E5),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffE5E5E5),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff4361EE),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 56,
                  child: TextFormField(
                    controller: _fullnameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffF8F9FA),
                      prefixIcon: const Icon(Typicons.user),
                      labelStyle: const TextStyle(
                          color: Color(0xffADADAD),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      labelText: 'Tên người dùng',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffE5E5E5),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffE5E5E5),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff4361EE),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 56,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffF8F9FA),
                      prefixIcon: const Icon(Icons.lock),
                      labelStyle: const TextStyle(
                          color: Color(0xffADADAD),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      labelText: 'Mật khẩu',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffE5E5E5),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffE5E5E5),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff4361EE),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff4361EE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      registerUser();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                    ),
                    child: const Text('Đăng ký'),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(top: 30),
            height: 380,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: const Color(0xff001124),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Lựa chọn khác',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Container(
                          width: 64,
                          height: 64,
                          margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              switch (index) {
                                case 0:
                                  // onPressed cho trang 1
                                  break;
                                case 1:
                                  // onPressed cho trang 2
                                  break;
                                case 2:
                                  // onPressed cho trang 3
                                  break;
                                default:
                                  break;
                              }
                            },
                            icon: Icon(
                              index == 0
                                  ? Icons.mail
                                  : index == 1
                                      ? Icons.facebook
                                      : Typicons.social_twitter,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Đã có tải khoản?',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              color: Color(0xff4361EE),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ApiService {
  static const String baseUrl = 'http://10.50.7.36:7000/api';

  static Future<Map<String, dynamic>> registerUser(
      String email, String fullname, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'fullname': fullname,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> data = json.decode(response.body);
        return {'success': true, 'data': data};
      } else {
        Map<String, dynamic> error = {'message': 'Registration unsuccessful'};
        return {'success': false, 'error': error};
      }
    } catch (error) {
      return {
        'success': false,
        'error': {'message': error.toString()}
      };
    }
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 20);
    path.quadraticBezierTo(
      size.width / 4 - 20,
      -20,
      size.width / 2,
      20,
    );
    path.quadraticBezierTo(
      size.width - (size.width / 4) + 20,
      60,
      size.width,
      10,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

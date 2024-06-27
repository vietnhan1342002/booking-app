import 'dart:convert';
import 'package:booking_app/provider/user_provider.dart';
import 'package:booking_app/screens/authentication/register_screen.dart';
import 'package:booking_app/screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Logger logger = Logger();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _loginUser(BuildContext context) async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      var result = await ApiService.loginUser(email, password);

      if (result['success']) {
        Map<String, dynamic>? userData = result['data'];
        if (userData != null && userData.containsKey('user')) {
          Map<String, dynamic> user = userData['user'];
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).setUserData(user);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationScreen(user: user),
            ),
          );
        } else {
          logger.e('Invalid user data');
        }
      } else {
        logger.i('Login unsuccessful!');
        logger.e('Error: ${result['error']['message']}');

        String errorMessage = 'Login unsuccessful.';

        if (result['error']['message'] != null) {
          errorMessage = result['error']['message'];
        }

        logger.e(errorMessage);
      }
    } catch (e) {
      logger.e('Error during login: $e');
      logger.e('An unexpected error occurred.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      'Đăng nhập',
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
                    'Đăng nhập tài khoản của bạn',
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
                      prefixIcon: const Icon(Typicons.user),
                      labelStyle: const TextStyle(
                          color: Color(0xffADADAD),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      labelText: 'Gmail người dùng',
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                        color: Color(0xff4361EE),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff4361EE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _loginUser(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                    ),
                    child: const Text('Đăng nhập'),
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
                                      ? Icons.phone
                                      : Icons.location_on,
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
                          'Chưa có tải khoản?',
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
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Đăng ký',
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

  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return {'success': true, 'data': data};
    } else {
      Map<String, dynamic> error = {'message': 'Login unsuccessful'};
      return {'success': false, 'error': error};
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

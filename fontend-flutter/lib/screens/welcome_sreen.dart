import 'package:booking_app/screens/authentication/login_screen.dart';
import 'package:booking_app/screens/authentication/register_screen.dart';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff001124),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 35),
            const Expanded(
              flex: 1,
              child: LogoWidget(),
            ),
            const SizedBox(height: 60),
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _controller,
                itemCount: 3,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return const WelcomeScreen1();
                    case 1:
                      return const WelcomeScreen2();
                    case 2:
                      return const WelcomeScreen3();
                    default:
                      return const WelcomeScreen1();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  width: currentIndex == index ? 25 : 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: currentIndex == index
                        ? const Color(0xff4361EE)
                        : const Color(0xffFFFFFF),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: 320,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentIndex == 3 - 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          );
                        }
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.bounceIn,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: const Color(0xff4361EE),
                      ),
                      child: Text(
                        currentIndex == 3 - 1 ? 'Tiếp tục' : 'Kế tiếp',
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Bạn đã có tài khoản? ",
                        style: TextStyle(
                          color: Color(0xffE5E5E5),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w200,
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
                          "Đăng nhập",
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen1 extends StatelessWidget {
  const WelcomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Stack(
          children: [
            DotMap(),
            Plane(),
          ],
        ),
        SizedBox(height: 50),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to ",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Text(
                  "Wanderlust",
                  style: TextStyle(
                    color: Color(0xff4361EE),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              "Ứng dụng đặt phòng khách sạn đa nền tảng",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            DotMap(),
            Positioned(
              left: 25,
              child: SizedBox(
                width: 318,
                height: 116,
                child: Text(
                  "Bạn muốn đặt chân đến nhiều nơi trên thế giới ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -130,
              top: 130,
              child: Plane1(),
            ),
          ],
        ),
      ],
    );
  }
}

class WelcomeScreen3 extends StatelessWidget {
  const WelcomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            DotMap(),
            Positioned(
              top: 50,
              left: 25,
              child: Plane2(),
            ),
            Positioned(
              left: 25,
              top: 220,
              child: SizedBox(
                width: 318,
                height: 210,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Hãy cùng chúng tôi khám phá ngay ứng dụng ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      TextSpan(
                        text: "Wanderlust",
                        style: TextStyle(
                          color: Colors.blue, // Màu khác
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DotMap extends StatelessWidget {
  const DotMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/world_map.png',
      width: 428.0,
      height: 215.0,
    );
  }
}

class Plane extends StatelessWidget {
  const Plane({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/plane.png',
      width: 401.0,
      height: 215.0,
    );
  }
}

class Plane1 extends StatelessWidget {
  const Plane1({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/plane_1.png',
      width: 639.0,
      height: 276.0,
    );
  }
}

class Plane2 extends StatelessWidget {
  const Plane2({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/plane_2.png',
      width: 357.0,
      height: 85.0,
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: 100.0,
      height: 100.0,
    );
  }
}

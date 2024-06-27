import 'package:booking_app/provider/booking_provider.dart';
import 'package:booking_app/provider/hotel_provider.dart';
import 'package:booking_app/screens/authentication/register_screen.dart';
import 'package:booking_app/screens/welcome_sreen.dart';
import 'package:booking_app/security/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:booking_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await Environment.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => HotelProvider()),
        ChangeNotifierProvider(create: (context) => BookingProvider()),
        Provider(create: (context) => ApiService()),
        // ...
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    // Determine whether to show WelcomeScreen or HomePageScreen
    Widget initialScreen = const WelcomeScreen(); // Change this line
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: initialScreen,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () {
            // Đóng bàn phím khi người dùng chạm vào bất kỳ nơi nào khác
            final currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: child,
        );
      },
    );
  }
}

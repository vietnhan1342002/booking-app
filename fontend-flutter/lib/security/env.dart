import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static late final String apiRegister;
  static late final String baseUrl;

  static Future<void> load() async {
    try {
      await dotenv.load(fileName: 'D:/Project/Flutter/booking_app/.env');
      apiRegister = dotenv.env['API_REGISTER']!;
      baseUrl = dotenv.env['BASE_URL']!;
    } catch (e) {
      print('Error loading .env file: $e');
    }
  }
}

// api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = '192.168.1.5:5000/api';

  Future<Map<String, dynamic>> bookRoom(
      String hotelId, Map<String, dynamic> bookingData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/booking/booking-room/$hotelId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bookingData),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to book room');
    }
  }
}

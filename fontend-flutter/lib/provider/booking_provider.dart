// booking_provider.dart
import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  Map<String, dynamic> _bookingData = {};

  Map<String, dynamic> get bookingData => _bookingData;

  void updateBookingData(Map<String, dynamic> newData) {
    _bookingData = newData;
    notifyListeners();
  }
}

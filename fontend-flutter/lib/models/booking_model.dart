import 'package:flutter/src/material/date.dart';

class BookingInfo {
  final DateTime checkin;
  final DateTime checkout;
  final int numberOfGuests;
  final int numberOfRooms;
  final String fullName;
  final String phoneNumber;
  final String gmail;

  BookingInfo({
    required this.checkin,
    required this.checkout,
    required this.numberOfGuests,
    required this.numberOfRooms,
    required this.fullName,
    required this.phoneNumber,
    required this.gmail,
    required DateTimeRange dateRange,
  });
}

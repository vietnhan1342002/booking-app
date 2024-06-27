import 'package:booking_app/models/hotel_model.dart';
import 'package:booking_app/models/phone_nation_model.dart';
import 'package:booking_app/provider/user_provider.dart';
import 'package:booking_app/screens/methods/confirm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:booking_app/data/phone_nation_data.dart';
import 'package:provider/provider.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class FirstPage extends StatefulWidget {
  final Map<String, dynamic> room;
  final Hotel accommodation;
  FirstPage({Key? key, required this.room, required this.accommodation})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  late Hotel _accommodation;
  late Map<String, dynamic> room;
  late DateTimeRange dateRange;
  late CountryInfo? selectedCountry;
  late DateTime start;
  late DateTime end;
  late bool isDateSelected;
  late TextEditingController numberOfGuestsController;
  late TextEditingController numberOfRoomsController;
  late TextEditingController fullNameController;
  late TextEditingController gmailController;
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    super.initState();
    room = widget.room;
    dateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now());
    selectedCountry =
        countryList.firstWhere((country) => country.dialCode == '+1');
    start = dateRange.start;
    end = dateRange.end;
    isDateSelected = false;
    numberOfGuestsController = TextEditingController();
    numberOfRoomsController = TextEditingController();
    fullNameController = TextEditingController();
    gmailController = TextEditingController();
    phoneNumberController = TextEditingController();
    _accommodation = widget.accommodation;
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi không cần thiết
    numberOfGuestsController.dispose();
    numberOfRoomsController.dispose();
    fullNameController.dispose();
    gmailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                'Form đặt phòng',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 100,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                color: const Color(0xffADADAD).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/uploads/${room['imageRoom']['public_id']}',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${room['typeRoom']} ${room['bedRoom']} ${room['numRoom']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\$${room['priceRoom']}/đêm',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nhận/Trả phòng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 170,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffE5E5E5),
                          width: 2.0,
                        ),
                        color: const Color(0xffF8F9FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          DateTimeRange? newdateRange =
                              await showDateRangePicker(
                                  context: context,
                                  initialDateRange: dateRange,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3000));
                          if (newdateRange == null) return;
                          setState(() {
                            dateRange = newdateRange;
                            isDateSelected = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color(0xffADADAD),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              isDateSelected ? 'Đã chọn' : 'Chọn ngày',
                              style: const TextStyle(
                                color: Color(0xffADADAD),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Khách',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 170,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F9FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: numberOfGuestsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.people),
                          hintText: 'Số lượng khách',
                          hintStyle: const TextStyle(
                            color: Color(0xffADADAD),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
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
                        onChanged: (value) {
                          // Cập nhật giá trị khi có thay đổi
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ngày đến',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 130,
                                child: Text(
                                  DateFormat.EEEE().format(dateRange.start),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                DateFormat.yMMMMd().format(dateRange.start),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_circle_right_sharp,
                          color: Color(0xff4361EE),
                          size: 35,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Ngày đi',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 130,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                DateFormat.EEEE().format(dateRange.end),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            DateFormat.yMMMMd().format(dateRange.end),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tên',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 210,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xffF8F9FA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: fullNameController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Typicons.user),
                            hintText: 'Họ và tên',
                            hintStyle: const TextStyle(
                              color: Color(0xffADADAD),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
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
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Phòng',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 130,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xffF8F9FA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: numberOfRoomsController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.meeting_room),
                            hintText: 'Số lượng',
                            hintStyle: const TextStyle(
                              color: Color(0xffADADAD),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
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
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Số điện thoại',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 120,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffE5E5E5),
                          width: 2.0,
                        ),
                        color: const Color(0xffF8F9FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const CountryCodePicker(
                        initialSelection: 'VN',
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 220,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F9FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          hintText: 'Nhập số điện thoại',
                          hintStyle: const TextStyle(
                            color: Color(0xffADADAD),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
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
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 56,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: const Color(0xffADADAD).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      Typicons.warning,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Để xác minh danh tính của bạn, mã xác minh sẽ được gửi đến số điện thoại ở trên.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gmail',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xffF8F9FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: gmailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: 'example@gmail.com',
                        hintStyle: const TextStyle(
                          color: Color(0xffADADAD),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Container(
          width: 170,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xff4361EE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            onPressed: () {
              handleBookingButtonPress(context);
            },
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              'Đặt phòng',
              style: TextStyle(
                color: Color(0xffADADAD),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleBookingButtonPress(BuildContext context) async {
    try {
      final userData =
          Provider.of<UserProvider>(context, listen: false).userData;

      final result = await ApiService.BookingHotel(
        email: gmailController.text,
        fullname: fullNameController.text,
        phone: int.parse(phoneNumberController.text),
        userId: userData?['_id'] ?? '',
        numOfGuest: int.parse(numberOfGuestsController.text),
        numOfRoom: int.parse(numberOfRoomsController.text),
        checkin: dateRange.start,
        checkout: dateRange.end,
        room: '${room['_id']}',
        total: int.parse('${room['priceRoom']}'),
        accommodationId: _accommodation.id,
      );

      // In log để kiểm tra kết quả
      print(result);

      if (result['success'] == true) {
        // Nếu đặt phòng thành công, chuyển đến trang đặt phòng thành công
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const ConfirmScreen(), // Thay thế bằng tên trang thành công của bạn
          ),
        );
      } else {
        // Xử lý nếu có lỗi trong quá trình đặt phòng
        // Hiển thị thông báo hoặc thực hiện các xử lý khác
      }
    } catch (error) {
      print(error);
    }
  }
}

String formatDateTime(DateTime dateTime) {
  return dateTime.toIso8601String();
}

class ApiService {
  static const String baseUrl = 'http://10.50.7.36:7000/api';

  static Future<Map<String, dynamic>> BookingHotel({
    required String email,
    required String room,
    required String fullname,
    required int phone,
    required int numOfGuest,
    required int numOfRoom,
    required String userId,
    required DateTime checkin,
    required DateTime checkout,
    required int total,
    required String accommodationId,
  }) async {
    try {
      final Uri url =
          Uri.parse('$baseUrl/booking/booking-room/$accommodationId');

      print('Request Data: ${jsonEncode({
            'room': room,
            'email': email,
            'fullname': fullname,
            'phone': phone,
            'userId': userId,
            'numOfGuest': numOfGuest,
            'numOfRoom': numOfRoom,
            'checkin': formatDateTime(checkin),
            'checkout': formatDateTime(checkout),
            'total': total,
            'hotelId': accommodationId,
          })}');

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'room': room,
          'email': email,
          'fullname': fullname,
          'phone': phone,
          'user_id': userId,
          'guest': numOfGuest,
          'quantity': numOfRoom,
          'checkin': formatDateTime(checkin),
          'checkout': formatDateTime(checkout),
          'total': total,
        }),
      );

      print('Response: ${response.body}');

      if (response.statusCode == 201) {
        Map<String, dynamic> data = json.decode(response.body);
        return {'success': true, 'data': data};
      } else {
        Map<String, dynamic> error = {'message': 'Registration unsuccessful'};
        return {'success': false, 'error': error};
      }
    } catch (error) {
      print('Error: $error');
      return {
        'success': false,
        'error': {'message': error.toString()}
      };
    }
  }
}

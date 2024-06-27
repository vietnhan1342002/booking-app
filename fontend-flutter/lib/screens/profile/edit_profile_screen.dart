import 'package:flutter/material.dart';
import 'package:booking_app/data/mysex_data.dart';
import 'package:booking_app/data/nation_data.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String selectedValue = mysex[0].value;
  String selectValue = nation[0].value;
  DateTime selecteDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedValue = mysex[0].value;
    selectValue = nation[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: IconButton(
              icon: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: const Color(0xffE5E5E5),
                  borderRadius: BorderRadius.circular(5),
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
            title: const Text(
              'Chỉnh sửa thông tin',
              style: TextStyle(
                  color: Color(0xff000000),
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.blue),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 56,
              width: 387,
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffF8F9FA),
                  labelStyle: const TextStyle(
                      color: Color(0xffADADAD),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  labelText: 'Tên người dùng',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xffE5E5E5), // Màu của đường biên
                      width: 1.0, // Kích thước của đường biên
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(
                          0xffE5E5E5), // Màu của đường biên khi không được focus
                      width:
                          1.0, // Kích thước của đường biên khi không được focus
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(
                          0xffE5E5E5), // Màu của đường biên khi được focus
                      width: 1.0, // Kích thước của đường biên khi được focus
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 56,
              width: 387,
              decoration: BoxDecoration(
                color: const Color(0xffF8F9FA),
                border: Border.all(width: 1, color: const Color(0xffE5E5E5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                underline: Container(),
                value: selectedValue,
                items: mysex.map((gender) {
                  return DropdownMenuItem(
                    value: gender.value,
                    child: Text(gender.select),
                  );
                }).toList(),
                style: const TextStyle(
                    color: Color(0xffADADAD),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue ?? '';
                  });
                },
                isExpanded: true,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 56,
              width: 387,
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: const Color(0xffF8F9FA),
                border: Border.all(width: 1, color: const Color(0xffE5E5E5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "${selecteDate.year}-${selecteDate.month}-${selecteDate.day}"),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () async {
                        final DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: selecteDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000));
                        if (dateTime != null) {
                          setState(() {
                            selecteDate = dateTime;
                          });
                        }
                      },
                      child: const Icon(Icons.date_range)),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 56,
              width: 387,
              decoration: BoxDecoration(
                color: const Color(0xffF8F9FA),
                border: Border.all(width: 1, color: const Color(0xffE5E5E5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                underline: Container(),
                value: selectValue,
                items: nation.map((nations) {
                  return DropdownMenuItem(
                    value: nations.value,
                    child: Text(nations.select),
                  );
                }).toList(),
                style: const TextStyle(
                    color: Color(0xffADADAD),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                onChanged: (String? newValue) {
                  setState(() {
                    selectValue = newValue ?? '';
                  });
                },
                isExpanded: true,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 56,
              width: 387,
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffF8F9FA),
                  labelStyle: const TextStyle(
                      color: Color(0xffADADAD),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  labelText: 'Số điện thoại',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xffE5E5E5), // Màu của đường biên
                      width: 1.0, // Kích thước của đường biên
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(
                          0xffE5E5E5), // Màu của đường biên khi không được focus
                      width:
                          1.0, // Kích thước của đường biên khi không được focus
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(
                          0xffE5E5E5), // Màu của đường biên khi được focus
                      width: 1.0, // Kích thước của đường biên khi được focus
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 56,
              width: 387,
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffF8F9FA),
                  labelStyle: const TextStyle(
                      color: Color(0xffADADAD),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  labelText: 'Gmail/Facebook/Twitter',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xffE5E5E5), // Màu của đường biên
                      width: 1.0, // Kích thước của đường biên
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(
                          0xffE5E5E5), // Màu của đường biên khi không được focus
                      width:
                          1.0, // Kích thước của đường biên khi không được focus
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(
                          0xffE5E5E5), // Màu của đường biên khi được focus
                      width: 1.0, // Kích thước của đường biên khi được focus
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4361EE),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    "Chỉnh sửa thông tin",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

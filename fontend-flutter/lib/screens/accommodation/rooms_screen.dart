import 'package:booking_app/data/type_data.dart';
import 'package:booking_app/screens/methods/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:booking_app/models/hotel_model.dart';

class RoomsScreen extends StatefulWidget {
  final Hotel accommodation;

  const RoomsScreen({Key? key, required this.accommodation}) : super(key: key);

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  late Hotel _accommodation;
  int selectedIndex = 0;
  int selectedRoomTypeIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    _accommodation = widget.accommodation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
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
            title: const Text(
              'Danh sách phòng',
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
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: type.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? const Color(0xff4361EE)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            type[index].typeName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : const Color(0xff4361EE),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            // Container có thể cuộn
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ListView.builder(
                itemCount: _accommodation.rooms.length,
                itemBuilder: (context, index) {
                  var room = _accommodation.rooms[index];
                  if (room['typeRoom'] == type[selectedIndex].typeName) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FirstPage(
                              room: room,
                              accommodation: _accommodation,
                            ),
                          ),
                        );
                      },
                      child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                child: Image.asset(
                                  'assets/uploads/${room['imageRoom']['public_id']}',
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${room['typeRoom']} ${room['bedRoom']}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '\$${room['priceRoom']}/',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff4361EE),
                                              ),
                                            ),
                                            const Text(
                                              'đêm',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff4361EE),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: room['statusRoom'] == 0
                                          ? const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Còn phòng',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff4361EE),
                                                ),
                                              ),
                                            )
                                          : const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'hết phòng',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Row(children: [
                                            const Icon(Icons.people),
                                            const SizedBox(width: 5),
                                            Text('${room['numGuestRoom']}')
                                          ]),
                                        ),
                                        const SizedBox(width: 5),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: const Row(children: [
                                            Icon(Icons.bathroom),
                                            SizedBox(width: 5),
                                            Text('1')
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

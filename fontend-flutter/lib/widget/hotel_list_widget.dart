import 'package:booking_app/screens/accommodation/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:booking_app/provider/hotel_provider.dart';
import 'package:provider/provider.dart';
import '../models/hotel_model.dart';
import 'package:page_transition/page_transition.dart';

class HotelWidget extends StatefulWidget {
  const HotelWidget({Key? key, required int categoryIndex}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HotelWidget();
}

class _HotelWidget extends State<HotelWidget> {
  final Logger logger = Logger();
  List<Hotel> accommodations = [];
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final hotelProvider = Provider.of<HotelProvider>(context, listen: false);
      hotelProvider.addListener(() {
        accommodations = List.from(hotelProvider.hotels);
        setState(() {});
      });

      hotelProvider.fetchHotels();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);
    if (hotelProvider.isLoading) {
      return const CircularProgressIndicator();
    } else {
      return Container(
        child: hotelProvider.hotels.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hotelProvider.hotels.length,
                      itemBuilder: (context, index) {
                        var accommodation = hotelProvider.hotels[index];
                        return Card(
                          margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            width: 350,
                            child: Stack(
                              children: [
                                ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.srcATop,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      accommodation.imageUrls.isNotEmpty
                                          ? accommodation.imageUrls[0]
                                          : 'placeholder_image_path',
                                      width: 350,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(top: 70),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            accommodation.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 16,
                                              ),
                                              Text(
                                                '(${accommodation.calculateAverageRating().toStringAsFixed(1)}/5)',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          Text(
                                            accommodation.address,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            '\$${accommodation.getMinRoomPrice()}',
                                            style: const TextStyle(
                                              color: Colors.amber,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            '/đêm',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  PageTransition(
                                                    child: DetailScreen(
                                                        accommodation:
                                                            accommodation),
                                                    type:
                                                        PageTransitionType.fade,
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xffE5E5E5),
                                                shadowColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                              child: const Text(
                                                'Chi tiết',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                      },
                    ),
                  ),
                ],
              )
            : Container(),
      );
    }
  }
}

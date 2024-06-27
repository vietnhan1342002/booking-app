import 'dart:ui';
import 'package:booking_app/provider/user_provider.dart';
import 'package:booking_app/screens/accommodation/rating_screen.dart';
import 'package:booking_app/screens/accommodation/rooms_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:booking_app/models/hotel_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class DetailScreen extends StatefulWidget {
  final Hotel accommodation;

  const DetailScreen({Key? key, required this.accommodation}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Hotel _accommodation;
  int ratingStar = 0;

  @override
  void initState() {
    super.initState();
    _accommodation = widget.accommodation;
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context, listen: false).userData;
    print(userData?['booking']);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height,
            floating: false,
            pinned: true,
            leading: backButton(context),
            actions: [
              favoriteButton(),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.asset(
                    _accommodation.imageUrls.isNotEmpty
                        ? _accommodation.imageUrls[0]
                        : 'placeholder_image_path',
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 360,
                          height: 180,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(57, 0, 0, 0),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: infoAcommodation(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          margin: const EdgeInsets.only(bottom: 50),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                color: Colors.black.withOpacity(0.3),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                  child: const Row(
                                    children: [
                                      Text('Xem thêm'),
                                      Icon(Icons.keyboard_arrow_down_sharp)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  infoAcommodation1(),
                  const SizedBox(height: 7),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Giới thiệu',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff4361EE),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          _accommodation.desc,
                          maxLines: 5,
                          overflow: TextOverflow.fade,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 7),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dịch vụ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff4361EE),
                          ),
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _accommodation.amenities.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 1.2),
                                      blurRadius: 5,
                                      color: const Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.25),
                                    ),
                                  ],
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _accommodation.amenities[index],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  tableStatesRating(),
                  userData?['booking'].isNotEmpty
                      ? Column(
                          children: [
                            const Text(
                              'Giá giá',
                              style: TextStyle(
                                  color: Color(0xff4361EE),
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                return IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RatingScreen(
                                            initialRating: index + 1,
                                            accommodation: _accommodation),
                                      ),
                                    );
                                    setState(() {
                                      ratingStar = index + 1;
                                    });
                                  },
                                  icon: Icon(
                                    index < ratingStar
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                  ),
                                );
                              }),
                            ),
                          ],
                        )
                      : Container(),
                  tabReviewLibrary(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DefaultTabController tabReviewLibrary() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Đánh giá'),
              Tab(text: 'Thư viện'),
            ],
            labelColor: Color(0xff4361EE),
            indicatorColor: Color(0xff4361EE),
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 300,
            child: TabBarView(
              children: [
                if (_accommodation.reviews.isEmpty)
                  const Center(
                    child: Text('Chưa có đánh giá.'),
                  )
                else
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _accommodation.reviews.length,
                    itemBuilder: (context, index) {
                      _accommodation.reviews.sort((a, b) {
                        DateTime createdAtA = DateTime.parse(a['createdAt']);
                        DateTime createdAtB = DateTime.parse(b['createdAt']);
                        return createdAtB.compareTo(createdAtA);
                      });
                      var reviewInfo = _accommodation.reviews[index];
                      return Container(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:
                                        Image.asset('assets/images/logo.png'),
                                  ),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '${reviewInfo['user_id']['fullname']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) {
                                        double rating = double.parse(
                                            reviewInfo['rating'].toString());
                                        IconData starIcon;

                                        if (rating >= index + 1) {
                                          starIcon = Icons.star;
                                        } else if (rating >= index + 0.5) {
                                          starIcon = Icons.star_half;
                                        } else {
                                          starIcon = Icons.star_border;
                                        }

                                        return Icon(
                                          starIcon,
                                          color: const Color(0xff4361EE),
                                          size: 15,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(
                                            reviewInfo['createdAt'])),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('${reviewInfo['comment']}'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                const Center(
                  child: Text('Nội dung Tab 2'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container tableStatesRating() {
    return Container(
      width: double.infinity,
      height: 140,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1.2),
            blurRadius: 5,
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  _accommodation.calculateAverageRating().toStringAsFixed(1),
                  style: const TextStyle(
                    color: Color(0xff4361EE),
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tổng quan',
                    style: TextStyle(
                      color: Color(0xffADADAD),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) {
                        double ratingFraction = double.parse(_accommodation
                                .calculateAverageRating()
                                .toStringAsFixed(1)) -
                            index;
                        IconData starIcon = ratingFraction >= 1
                            ? Icons.star
                            : ratingFraction >= 0.5
                                ? Icons.star_half
                                : Icons.star_border;

                        return Icon(
                          starIcon,
                          color: const Color(0xff4361EE),
                          size: 20,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: ratingTable(),
          )
        ],
      ),
    );
  }

  List<Widget> ratingTable() {
    List<int> ratingStats = _accommodation.calculateRatingStats();
    int totalReviews = _accommodation.reviews.length ?? 0;

    return List.generate(5, (index) {
      final starIndex = index + 1;
      final progressValue = (ratingStats[index] ?? 0) / totalReviews;
      return Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              '$starIndex',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: progressValue.isFinite ? progressValue : 0,
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xff4361EE),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      );
    });
  }

  Column infoAcommodation1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(
              _accommodation.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff4361EE),
              ),
            ),
            const Spacer(),
            Text(
              '\$${_accommodation.getMinRoomPrice()}',
              style: const TextStyle(
                color: Color(0xff4361EE),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              _accommodation.address,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: const Icon(
                Icons.location_city,
                size: 17,
                color: Color(0xff4361EE),
              ),
            ),
            Text(
              _accommodation.desc,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Text(
              '/đêm',
              style: TextStyle(),
            ),
          ],
        ),
      ],
    );
  }

  Column infoAcommodation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _accommodation.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              _accommodation.address,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: const Icon(
                Icons.location_city,
                size: 17,
                color: Colors.amber,
              ),
            ),
            Text(
              _accommodation.desc,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Text(
              '\$${_accommodation.getMinRoomPrice()}',
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Row(
              children: List.generate(
                5,
                (index) {
                  double ratingFraction = double.parse(_accommodation
                          .calculateAverageRating()
                          .toStringAsFixed(1)) -
                      index;
                  IconData starIcon = ratingFraction >= 1
                      ? Icons.star
                      : ratingFraction >= 0.5
                          ? Icons.star_half
                          : Icons.star_border;

                  return Icon(
                    starIcon,
                    color: Colors.amber,
                    size: 20,
                  );
                },
              ),
            ),
            const SizedBox(width: 5),
            Text(
              _accommodation.calculateAverageRating().toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            const Text(
              '/đêm',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          width: 340,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                PageTransition(
                  child: RoomsScreen(accommodation: _accommodation),
                  type: PageTransitionType.fade,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: const Color(0xff4361EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Chọn phòng',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container favoriteButton() {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.only(right: 20),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(65, 0, 0, 0),
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Typicons.heart),
        color: Colors.white,
        iconSize: 20,
      ),
    );
  }

  Container backButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: IconButton(
        icon: Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            color: Color.fromARGB(65, 0, 0, 0),
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
    );
  }
}

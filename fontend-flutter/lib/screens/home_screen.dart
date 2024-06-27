import 'package:booking_app/provider/user_provider.dart';
import 'package:booking_app/widget/hotel_list_widget.dart';
import 'package:booking_app/widget/villa_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:booking_app/data/category_data.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageScreen> {
  int selectedCategoryIndex = 0;
  int selectedSortingOptionIndex = 0;
  String selectedSortingOptionText = 'Tất cả';
  int previousSelectedCategoryIndex = 0;
  Map<int, List<String>> sortingOptionsMap = {};

  late Widget selectedCategoryWidget;

  Map<int, Widget> categoryWidgets = {
    0: HotelWidget(categoryIndex: 0),
    1: VillaWidget(categoryIndex: 1),
    // Thêm các Widget khác tương ứng với các danh mục khác nếu cần
  };

  @override
  void initState() {
    super.initState();
    selectedCategoryIndex = 0;
    selectedSortingOptionIndex = 0;
    for (int i = 0; i < categories.length; i++) {
      sortingOptionsMap[i] = List.from(categories[i].sortingOptions);
    }

    selectedCategoryWidget =
        categoryWidgets[selectedCategoryIndex] ?? Container();
  }

  void updateSortingOptions() {
    if (sortingOptionsMap[selectedCategoryIndex] == null) {
      sortingOptionsMap[selectedCategoryIndex] =
          List.from(categories[selectedCategoryIndex].sortingOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: avatarUsername(),
        actions: [
          appBarButtons(),
        ],
        leadingWidth: 20,
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bạn muốn đi đâu ?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffADADAD),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                searchFilter(),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Danh mục',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 134,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // Cập nhật Widget hiện tại dựa trên danh mục được chọn
                            categoryWidgets.containsKey(index)
                                ? categoryWidgets[index]!
                                : Container();
                          });
                        },
                        child: Container(
                          width: 200,
                          height: 114,
                          margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1.2),
                                blurRadius: 5,
                                color: const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.25),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(
                                      selectedCategoryIndex == index ? 0 : 0.4),
                                  BlendMode.srcATop,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    categories[index].imageUrl,
                                    width: 200,
                                    height: 114,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Text(
                                  categories[index].name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decorationThickness: 2.0,
                                    decorationColor:
                                        selectedCategoryIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedSortingOptionText,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffE5E5E5),
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Xem thêm',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        sortingOptionsMap[selectedCategoryIndex]?.length ?? 0,
                    itemBuilder: (context, index) {
                      bool isItemSelected = selectedSortingOptionIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              selectedSortingOptionIndex = index;
                              sortingOptionsMap[selectedCategoryIndex] =
                                  List.from(categories[selectedCategoryIndex]
                                      .sortingOptions);
                              selectedSortingOptionText =
                                  sortingOptionsMap[selectedCategoryIndex]
                                          ?[index] ??
                                      '';

                              if (selectedSortingOptionIndex == 0 &&
                                  selectedCategoryIndex !=
                                      previousSelectedCategoryIndex) {
                                selectedSortingOptionText =
                                    sortingOptionsMap[selectedCategoryIndex]
                                            ?.first ??
                                        '';
                              }

                              // Lưu lại index của danh mục cha đã chọn
                              previousSelectedCategoryIndex =
                                  selectedCategoryIndex;
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                sortingOptionsMap[selectedCategoryIndex]
                                        ?[index] ??
                                    '',
                                style: TextStyle(
                                  color: isItemSelected
                                      ? const Color(0xff4361EE)
                                      : const Color(0xffADADAD),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                  width:
                                      (sortingOptionsMap[selectedCategoryIndex]
                                                      ?[index]
                                                  .length ??
                                              0) *
                                          6.0,
                                  height: 2,
                                  color: isItemSelected
                                      ? const Color(0xff4361EE)
                                      : null),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                selectedCategoryWidget,
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Địa điểm phổ biến',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffE5E5E5),
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Xem thêm',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row searchFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 280,
          height: 50,
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1.2),
                blurRadius: 5,
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
              ),
            ],
          ),
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: const Icon(Icons.search),
                color: const Color(0xffADADAD),
                onPressed: () {},
              ),
              hintText: 'Tìm kiếm khách sạn',
              hintStyle: const TextStyle(
                color: Color(0xffADADAD),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              fillColor: Colors.white,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 16, top: 14),
            ),
          ),
        ),
        Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(right: 20, top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xff4361EE),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1.2),
                blurRadius: 5,
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Row avatarUsername() {
    final userData = Provider.of<UserProvider>(context, listen: false).userData;
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/user_avatar.png'),
          radius: 20,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Xin chào!',
              style: TextStyle(
                color: Color(0xffADADAD),
                fontSize: 14,
              ),
            ),
            Text(
              userData?['fullname'] ?? '',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Row appBarButtons() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(right: 5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffE5E5E5),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_month),
            color: Colors.black,
            iconSize: 20,
          ),
        ),
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(right: 20),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffE5E5E5),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            color: Colors.black,
            iconSize: 20,
          ),
        ),
      ],
    );
  }
}

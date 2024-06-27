import 'package:booking_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                'Hồ sơ người dùng',
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
        body: Consumer<UserProvider>(builder: (context, userProvider, child) {
          Map<String, dynamic>? userData = userProvider.userData;
          return ListView(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      const UserAvatar(),
                      const SizedBox(height: 38),
                      Column(
                        children: [
                          UserProfileWidget(
                            icon: Icons.tag_faces_rounded,
                            title: "Tên tài khoản",
                            subtitle: userData != null
                                ? userData['email'] ?? 'Không có email'
                                : 'Không có dữ liệu',
                          ),
                          const UserProfileWidget(
                            icon: Icons.flag_rounded,
                            title: "Quốc tịch",
                            subtitle: "Việt Nam",
                          ),
                          const UserProfileWidget(
                            icon: Icons.phone,
                            title: "Số điện thoại",
                            subtitle: "09xxxxx123",
                          ),
                          const UserProfileWidget(
                            icon: Icons.cake,
                            title: "Năm sinh",
                            subtitle: "01/02/2002",
                          ),
                          const UserProfileWidget(
                            icon: Icons.transgender,
                            title: "Giới tính",
                            subtitle: "Nam",
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4361EE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Cập nhật thông tin",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          OptionWidget(
                            title1: 'Cài đặt',
                            subtitle1: 'Hệ thống',
                            icon1: Icons.settings,
                            onTap: () {},
                          ),
                          OptionWidget(
                            title1: 'Lịch sử đặt phòng',
                            subtitle1: 'Không có',
                            icon1: Icons.av_timer,
                            onTap: () {},
                          ),
                          OptionWidget(
                            title1: 'Đăng xuất',
                            subtitle1: 'Thoát',
                            icon1: Icons.logout,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }));
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 148,
          height: 148,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          "Tên người dùng",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 7,
        ),
        const Text(
          "Member Gold",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xffC8C349),
              decoration: TextDecoration.underline),
        ),
      ],
    );
  }
}

class OptionWidget extends StatefulWidget {
  const OptionWidget({
    Key? key,
    required this.title1,
    required this.subtitle1,
    required this.icon1,
    this.textColor,
    required this.onTap,
  }) : super(key: key);

  final String title1;
  final String subtitle1;
  final IconData icon1;
  final Color? textColor;
  final VoidCallback onTap;

  @override
  State<OptionWidget> createState() => OptionWidgetState();
}

class OptionWidgetState extends State<OptionWidget> {
  late String title1;
  late String subtitle1;
  late IconData icon1;
  late VoidCallback onTap;

  @override
  void initState() {
    super.initState();
    title1 = widget.title1;
    subtitle1 = widget.subtitle1;
    icon1 = widget.icon1;
    onTap = widget.onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon1,
              color: const Color(0xff4361EE),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title1,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  subtitle1,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Color(0xffADADAD),
                      overflow: TextOverflow.clip),
                ),
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Color(0xffADADAD),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.textColor,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xff4361EE),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
          const Spacer(),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 17, color: Color(0xffADADAD)),
          ),
        ],
      ),
    );
  }
}

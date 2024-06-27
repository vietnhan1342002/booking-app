import 'package:flutter/material.dart';
import 'package:booking_app/screens/profile/profile_screen.dart';
import 'package:booking_app/components/bottom_navigation_bar.dart';
import 'package:booking_app/screens/home_screen.dart';

class NavigationScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const NavigationScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentPageIndex = 0;
  bool _isNavigationBarVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTabTapped: (index) {
          _updatePageIndex(index);
        },
        isVisible: _isNavigationBarVisible,
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentPageIndex) {
      case 0:
        return HomePageScreen();
      case 1:
        return ProfileScreen();
      case 2:
        return HomePageScreen();
      case 3:
        return ProfileScreen();
      case 4:
        return ProfileScreen();
      default:
        return Container();
    }
  }

  void _updatePageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
      _isNavigationBarVisible = true;
    });
  }
}

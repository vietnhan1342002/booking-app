import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:booking_app/data/navigation_bar_data.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onTabTapped;
  final bool isVisible;

  const CustomBottomNavigationBar({
    Key? key,
    required this.onTabTapped,
    this.isVisible = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedButtonIndex = 2;

  @override
  void initState() {
    super.initState();

    buttons[selectedButtonIndex].isSelected = true;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: CurvedNavigationBar(
          height: 60,
          index: selectedButtonIndex,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          buttonBackgroundColor: const Color(0xff4361EE),
          items: buttons.map((button) {
            return Icon(
              button.icon,
              size: 30,
              color: button.isSelected ? Colors.white : const Color(0xff4361EE),
            );
          }).toList(),
          onTap: (index) {
            setState(() {
              selectedButtonIndex = index;

              for (int i = 0; i < buttons.length; i++) {
                buttons[i].isSelected = (i == index);
              }
            });

            widget.onTabTapped(index);
          },
        ),
      ),
    );
  }
}

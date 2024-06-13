import 'package:flutter/material.dart';
import 'package:khushi_creation/screens/main_screen/chat_screen.dart';
import 'package:khushi_creation/screens/main_screen/profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khushi_creation/screens/main_screen/home_screen.dart';
import 'package:khushi_creation/screens/main_screen/cart_screen.dart';
import 'package:khushi_creation/screens/main_screen/whishlist_screen.dart';




class BottomNavBar extends StatefulWidget {
  final String? currentLocation;

  BottomNavBar({
    this.currentLocation,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  List<Widget> get _pages {
    return [
      HomeScreen(currentLocation: widget.currentLocation),
      CartScreen(),
      WishlistScreen(),
      ChatScreen(),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Positioned(
            left: 20.0.w,
            right: 20.0.w,
            bottom: 20.0.h,
            child: Container(
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem('assets/svg/home.svg', 0),
                    _buildNavItem('assets/svg/shopping-bag.svg', 1),
                    _buildNavItem('assets/svg/heart.svg', 2),
                    _buildNavItem('assets/svg/chat-square-dots-fill.svg', 3),
                    _buildNavItem('assets/svg/profile.svg', 4),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String assetName, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: CircleAvatar(
        backgroundColor:
            _selectedIndex == index ? Color(0xffFFFFFF) : Colors.transparent,
        child: SvgPicture.asset(
          assetName,
          colorFilter: ColorFilter.mode(
              _selectedIndex == index ? Colors.brown : Colors.grey,
              BlendMode.srcIn),
          width: 25.0,
          height: 25.0,
        ),
      ),
    );
  }
}

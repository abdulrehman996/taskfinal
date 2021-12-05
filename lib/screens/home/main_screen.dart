import 'dart:ui';

import 'package:biz_link/screens/home/cart_page.dart';
import 'package:biz_link/screens/home/category_page.dart';
import 'package:biz_link/screens/home/home_page.dart';
import 'package:biz_link/screens/home/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../others/bottom_appbar_index.dart';
import '../../utility/colors.dart';

class MaineScreen extends StatefulWidget {
  const MaineScreen({Key? key}) : super(key: key);
  static const String routeName = '/main-screen';
  @override
  State<MaineScreen> createState() => _MaineScreenState();
}

class _MaineScreenState extends State<MaineScreen> {
  int _currentIndex = 0;
  BottomAppbarIndex bottomAppbarIndex = BottomAppbarIndex();

  var _children = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    ProfilePage(),
  ];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar:
          // GNav(
          //   rippleColor: Colors.grey.shade300,
          //   // tab button ripple color when pressed
          //   hoverColor: Colors.grey.shade100,
          //   // tab button hover color
          //   haptic: true,
          //
          //   // haptic feedback
          //   // tabBorderRadius: 15,
          //   // tabActiveBorder: Border.all(color: MyColor.soft_accent_color, width: 1),
          //   // // tab button border
          //   // tabBorder: Border.all(color: MyColor.soft_accent_color, width: 1),
          //   // // tab button border
          //   // tabShadow: [
          //   //   BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
          //   // ],
          //   // // tab button shadow
          //   // curve: Curves.easeOutQuad,
          //   // // tab animation curves
          //
          //   duration: Duration(milliseconds: 300),
          //   // tab animation duration
          //   gap: 8,
          //   // the tab button gap between icon and text
          //   color: MyColor.soft_accent_color.withOpacity(0.60),
          //   // unselected icon color
          //   activeColor: MyColor.accent_color,
          //   // selected icon and text color
          //   iconSize: 24,
          //   // tab button icon size
          //   tabBackgroundColor:  Colors.grey.shade100,
          //   // selected tab background color
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          //   // navigation bar padding
          //   onTabChange: onTapped,
          //   tabs: [
          //     GButton(
          //       icon: Icons.home,
          //       text: 'Home',
          //     ),
          //     GButton(
          //       icon: Icons.category_outlined,
          //       text: 'Shops',
          //     ),
          //     GButton(
          //       icon: Icons.search,
          //       text: 'Search',
          //     ),
          //     GButton(
          //       icon: Icons.person,
          //       text: 'Profile',
          //     )
          //   ],
          // ),

          BottomAppBar(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: SizedBox(
            height: 83,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: onTapped,
              currentIndex: _currentIndex,
              backgroundColor: Colors.white.withOpacity(0.95),
              unselectedItemColor: Color.fromRGBO(168, 175, 179, 1),
              selectedItemColor: MyColor.accent_color,
              selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: MyColor.accent_color,
                  fontSize: 12),
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(168, 175, 179, 1),
                  fontSize: 12),
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        Icons.home,
                        color: _currentIndex == 0
                            ? MyColor.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        size: 16,
                      ),
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        Icons.category_outlined,
                        color: _currentIndex == 1
                            ? MyColor.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        size: 16,
                      ),
                    ),
                    label: 'Category'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: _currentIndex == 2
                            ? MyColor.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        size: 16,
                      ),
                    ),
                    label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        Icons.person,
                        color: _currentIndex == 3
                            ? MyColor.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        size: 16,
                      ),
                    ),
                    label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

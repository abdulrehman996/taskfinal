import 'package:biz_link/database/auth_methods.dart';
import 'package:biz_link/models/app_user.dart';
import 'package:biz_link/providers/user_provider.dart';
import 'package:biz_link/screens/auth/login_page.dart';
import 'package:biz_link/screens/product_screens/my_product_screen.dart';
import 'package:biz_link/widgets/circle_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../utility/colors.dart';
import '../chat/personal_chat_page/personal_chat_dashboard.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _cartCounterString = "...";
  String _wishlistCounterString = "...";
  String _orderCounterString = "...";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: 45.h,
          width: 100.w,
          color: MyColor.accent_color,
          alignment: Alignment.topRight,
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 28.0),
                child: buildTopSection(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 10.0),
                child: buildCountersRow(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 10.0),
                child: buildSettingAndAddonsVerticalMenu(),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget buildTopSection() {
    return Consumer<UserProvider>(builder: (context, userPro, _) {
      final AppUser me = userPro.user(uid: AuthMethods.uid);
      return Container(
        // color: Colors.amber,
        alignment: Alignment.center,
        height: 48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              // backgroundImage: AssetImage('assets/images/avatar.jpg'),
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
              backgroundColor: MyColor.amber,
            ),
            // CircleImage(
            //     imageUrl:
            //         'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80'),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  me.displayName ?? 'null',
                  style: TextStyle(
                    fontSize: 14,
                    color: MyColor.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    me.email ?? 'null@null.com',
                    style: TextStyle(
                      color: MyColor.light_grey,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              width: 70,
              height: 26,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColor.noColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: MyColor.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                ),
                child: Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () async {
                  await AuthMethods().signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildCountersRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildCountersRowItem(
          _cartCounterString,
          'Cart',
        ),
        buildCountersRowItem(
          _wishlistCounterString,
          'Wish List',
        ),
        buildCountersRowItem(
          _orderCounterString,
          'Your Ordered',
        ),
      ],
    );
  }

  Widget buildCountersRowItem(String counter, String title) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(vertical: 14),
      width: 100.w / 3.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: MyColor.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            counter,
            maxLines: 2,
            style: TextStyle(
                fontSize: 16,
                color: MyColor.dark_font_grey,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            maxLines: 2,
            style: TextStyle(
              color: MyColor.dark_font_grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSettingAndAddonsVerticalMenu() {
    return Container(
      margin: EdgeInsets.only(bottom: 120, top: 14),
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.00),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 20,
            spreadRadius: 0.0,
            offset: Offset(0.0, 10.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/edit.png",
                    width: 16,
                    height: 16,
                    color: MyColor.dark_font_grey,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    'Edit Profile',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: MyColor.dark_font_grey, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: MyColor.light_grey,
          ),
          Container(
            height: 40,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/orders.png",
                    width: 16,
                    height: 16,
                    color: MyColor.dark_font_grey,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    'My Orders',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: MyColor.dark_font_grey, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: MyColor.light_grey,
          ),
          Container(
            height: 40,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/heart.png",
                    width: 16,
                    height: 16,
                    color: MyColor.dark_font_grey,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    'My Wishlist',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: MyColor.dark_font_grey, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: MyColor.light_grey,
          ),
          Container(
            height: 40,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(MyProductScreen.routeName);
              },
              style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.my_library_books_rounded),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    'My Products',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: MyColor.dark_font_grey, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: MyColor.light_grey,
          ),
          Container(
            height: 40,
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(PersonalChatDashboard.routeName);
              },
              style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/messages.png",
                    width: 16,
                    height: 16,
                    color: MyColor.dark_font_grey,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    'Messages',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: MyColor.dark_font_grey, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:biz_link/database/auth_methods.dart';
import 'package:biz_link/screens/auth/login_page.dart';
import 'package:biz_link/screens/home/main_screen.dart';
import 'package:biz_link/utility/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AuthMethods.uid.isNotEmpty ? MaineScreen() : const LoginPage(),
        ),
      );
    });
  }

  @override
  void initState() {
    getState();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColor.splash_screen_color,
      child: Center(
        child: Image.asset("assets/images/BizLink_transparent.png"),
      ),
    );
  }
}

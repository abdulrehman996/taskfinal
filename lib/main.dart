import 'package:biz_link/utility/colors.dart';

import '../screens/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'others/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (
      BuildContext context,
      Orientation orientation,
      deviceType,
    ) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: MyColor.accent_color,
          colorScheme: ColorScheme(
            primary: MyColor.accent_color,
            secondary: MyColor.soft_accent_color,
            surface: Colors.white,
            background: Colors.white,
            error: Colors.red,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.grey,
            onBackground: Colors.grey,
            onError: Colors.red,
            brightness: Brightness.light,
          ),
        ),
        home: SplashScreen(),
      );
    });
  }
}

import 'package:biz_link/providers/product_category_provider.dart';
import 'package:biz_link/providers/user_provider.dart';
import 'package:biz_link/screens/home/main_screen.dart';
import 'package:biz_link/screens/product_screens/add_product_screen.dart';
import 'package:biz_link/utility/colors.dart';
import 'package:provider/provider.dart';

import '../screens/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'others/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ProdCatProvider()),
      ],
      child: Sizer(builder: (
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
          routes: {
            LoginPage.routeName: (_) => const LoginPage(),
            MaineScreen.routeName: (_) => const MaineScreen(),

            // Product
            AddProductScreen.routeName: (_) => const AddProductScreen(),
          },
        );
      }),
    );
  }
}

import 'package:biz_link/enums/role.dart';
import 'package:biz_link/models/product/product.dart';
import 'package:biz_link/providers/product_provider.dart';
import 'package:biz_link/providers/user_provider.dart';
import 'package:biz_link/screens/chat/personal_chat_page/personal_chat_dashboard.dart';
import 'package:biz_link/widgets/product/grid_view_of_prod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../database/auth_methods.dart';
import '../../utility/colors.dart';
import '../../widgets/custom_widgets/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int yourActiveIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(AuthMethods.uid);
    final Role myRole =
        Provider.of<UserProvider>(context).user(uid: AuthMethods.uid).role;
    final List<Product> products =
        Provider.of<ProductProvider>(context).products(myRole.json);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).pushNamed(PersonalChatDashboard.routeName);
            },
            icon: Icon(Icons.chat),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 23.h,
            width: 100.w,
            color: MyColor.accent_color,
            alignment: Alignment.topRight,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Container(child: BannerWidget()),
                  const SizedBox(
                    height: 20,
                  ),
                  GridViewOfProducts(posts: products),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

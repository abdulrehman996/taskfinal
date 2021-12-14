import 'package:biz_link/enums/role.dart';
import 'package:biz_link/models/product/product.dart';
import 'package:biz_link/providers/product_provider.dart';
import 'package:biz_link/providers/user_provider.dart';
import 'package:biz_link/screens/auth/login_page.dart';
import 'package:biz_link/screens/chat/personal_chat_page/personal_chat_dashboard.dart';
import 'package:biz_link/screens/product_screens/add_product_screen.dart';
import 'package:biz_link/widgets/product/grid_view_of_prod.dart';
import 'package:biz_link/widgets/product/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/auth_methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add Product'),
                subtitle: Text('Click here to add your product'),
                onTap: () {
                  Navigator.of(context).pushNamed(AddProductScreen.routeName);
                },
              ),
              GridViewOfProducts(posts: products),
            ],
          ),
        ),
      ),
    );
  }
}

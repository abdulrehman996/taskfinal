import 'package:biz_link/screens/auth/login_page.dart';
import 'package:biz_link/screens/product_screens/add_product_screen.dart';
import 'package:flutter/material.dart';

import '../../database/auth_methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthMethods().signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginPage.routeName, (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
          ],
        ),
      ),
    );
  }
}

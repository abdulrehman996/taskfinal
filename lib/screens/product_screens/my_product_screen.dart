import 'package:biz_link/database/auth_methods.dart';
import 'package:biz_link/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/product/grid_view_of_prod.dart';
import 'add_product_screen.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key});

  static const String routeName = '/my-products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Products')),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
              Consumer<ProductProvider>(
                builder: (context, prodPro, _) {
                  return GridViewOfProducts(
                      posts: prodPro.productsByUID(AuthMethods.uid));
                },
              ),
            ],
          ),
        ),
      ),


    );
  }
}

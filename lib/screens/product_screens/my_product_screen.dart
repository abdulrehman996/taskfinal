import 'package:biz_link/database/auth_methods.dart';
import 'package:biz_link/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/product/grid_view_of_prod.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key});
  static const String routeName = '/my-products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('My Products')),
        body: Consumer<ProductProvider>(
          builder: (context, prodPro, _) {
            return GridViewOfProducts(
                posts: prodPro.productsByUID(AuthMethods.uid));
          },
        ));
  }
}

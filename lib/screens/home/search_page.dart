import 'package:biz_link/providers/product_provider.dart';
import 'package:biz_link/widgets/product/grid_view_of_prod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../database/auth_methods.dart';
import '../../enums/role.dart';
import '../../models/product/product.dart';
import '../../providers/user_provider.dart';
import '../../utility/colors.dart';
import '../../widgets/sellers_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    print(AuthMethods.uid);
    final Role myRole =
        Provider.of<UserProvider>(context).user(uid: AuthMethods.uid).role;
    final List<Product> products =
    Provider.of<ProductProvider>(context).products(myRole.json);
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Consumer<ProductProvider>(builder: (context, prodPro, _) {
        final filteredProducts = searchTerm.isEmpty
            ? products
            : products.where((product) =>
            product.title.toLowerCase().contains(searchTerm.toLowerCase()));

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                CupertinoSearchTextField(
                  onChanged: (value) {
                    setState(() {
                      searchTerm = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                GridViewOfProducts(posts: filteredProducts.toList()),
              ],
            ),
          ),
        );
      }),
    );
  }
}

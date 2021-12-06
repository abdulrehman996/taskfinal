import 'package:biz_link/providers/product_provider.dart';
import 'package:biz_link/widgets/product/grid_view_of_prod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../utility/colors.dart';
import '../../widgets/sellers_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> _shopList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Consumer<ProductProvider>(builder: (context, prodPro, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                CupertinoSearchTextField(
                  onChanged: (value) => prodPro.onSearch(value),
                ),
                const SizedBox(height: 16),
                GridViewOfProducts(posts: prodPro.filter())
              ],
            ),
          ),
        );
      }),
    );
  }
}

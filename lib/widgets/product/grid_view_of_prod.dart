import 'package:flutter/material.dart';
import '../../models/product/product.dart';
import '../../screens/product_screens/product_detail_screen.dart';
import '../custom_widgets/custom_network_image.dart';

class GridViewOfProducts extends StatelessWidget {
  const GridViewOfProducts({
    required this.posts,
    this.isProfileWidget = true,
    Key? key,
  }) : super(key: key);
  final List<Product> posts;
  final bool isProfileWidget;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 4 / 5,
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.of(context).push(
              //   isProfileWidget
              //       ? MaterialPageRoute<UserProductsScreen>(
              //           builder: (_) => UserProductsScreen(
              //               products: posts, selectedIndex: index),
              //         )
              //       :
              MaterialPageRoute<ProductDetailScreen>(
                builder: (_) => ProductDetailScreen(product: posts[index]),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.1),
                  offset: const Offset(0, 0),
                  blurRadius: 1,
                  spreadRadius: 3,
                )
              ],
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: CustomNetworkImage(
                        imageURL: posts[index].prodURL[0].url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${posts[index].title}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            posts[index].price.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      splashRadius: 12,
                      icon: const Icon(Icons.shopping_cart_checkout_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

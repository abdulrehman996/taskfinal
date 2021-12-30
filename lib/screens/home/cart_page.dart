import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../widgets/cart/empty_cart_widget.dart';
import '../../widgets/cart/fill_cart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: cartPro.cartItem.isNotEmpty
          ? Column(
        children: <Widget>[
          Expanded(child: const FillCartWidget()),
        ],
      )
          : const EmptyCartWidget(),
    );
  }
}

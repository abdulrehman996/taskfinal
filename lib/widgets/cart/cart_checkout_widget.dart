import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../custom_widgets/custom_elevated_button.dart';
import 'checkout/check_out_widget.dart';

class CartCheckoutWidget extends StatelessWidget {
  const CartCheckoutWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (
      BuildContext context,
      CartProvider cartPro,
      _,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Divider(),
            Row(
              children: <Widget>[
                const Text('Select Item'),
                const Spacer(),
                Text(cartPro.cartItem.length.toString()),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                const Text(
                  'Total Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text('PKR: ${cartPro.totalPrice()}'),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 60,
              child: CustomElevatedButton(
                title: 'Check out',
                borderRadius: BorderRadius.circular(24),
                onTap: () async {
                  await HapticFeedback.heavyImpact();
                  cartPro.deleteAllItem();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckoutDetails(),));
                  //_showConfirmationDialog(context);
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    });
  }
}

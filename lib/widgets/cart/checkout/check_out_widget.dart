import 'package:biz_link/widgets/custom_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';
import '../../custom_widgets/custom_text_widget.dart';
import '../add_credit sheet.dart';

class CheckoutDetails extends StatefulWidget {
  CheckoutDetails({
    super.key,
  });

  @override
  State<CheckoutDetails> createState() => _CheckoutDetailsState();
}

class _CheckoutDetailsState extends State<CheckoutDetails> {
  
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro=Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: CustomText(
          text: "Checkout",
          bold: true,
          color: Colors.white,
          size: 16,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                      SizedBox(height: 30),
                      CustomElevatedButton(
                          title: 'payment',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.black.withOpacity(.7),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              builder: (context) => Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: AddCreditSheet(),
                              ),
                            );
                          }),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: "Secure Checkout",
                          size: 11,
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

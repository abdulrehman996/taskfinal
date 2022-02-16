import 'package:biz_link/providers/cart_provider.dart';
import 'package:biz_link/screens/home/main_screen.dart';
import 'package:biz_link/widgets/custom_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/payment_provider.dart';
import '../custom_widgets/custom_text_form_with_header.dart';
import '../custom_widgets/custom_text_widget.dart';

class AddCreditSheet extends StatefulWidget {
  AddCreditSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AddCreditSheet> createState() => _AddCreditSheetState();
}

class _AddCreditSheetState extends State<AddCreditSheet> {
  TextEditingController _cardNumber = TextEditingController();

  TextEditingController _nameonCard = TextEditingController();

  TextEditingController _expirydate = TextEditingController();

  TextEditingController _securityCode = TextEditingController();

  String month = 'mm';

  String year = 'yy';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 2),
          decoration: getBottomSheetDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text("Visa Credit Card Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        )),
                    CustomTextFormFieldWithHeader(
                      headerText: "Card Number",
                      controller: _cardNumber,
                      gradientBorder: true,
                      inputFormatters: LengthLimitingTextInputFormatter(10),
                      keyboardType: TextInputType.number,
                      headerPadding: const EdgeInsets.only(left: 8),
                      Boardercolor: Colors.transparent,
                      color: Colors.grey,
                      hintColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                    ),
                    CustomTextFormFieldWithHeader(
                      headerText: "Name on Card",
                      controller: _nameonCard,
                      gradientBorder: true,
                      headerPadding: const EdgeInsets.only(left: 8),
                      Boardercolor: Colors.transparent,
                      color: Colors.grey,
                      hintColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormFieldWithHeader(
                            headerText: "Expiry Date",
                            controller: _expirydate,
                            readOnly: true,
                            hint: month + '/' + year,
                            gradientBorder: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2024));

                              if (pickedDate != null) {
                                setState(() {
                                  month = pickedDate.month.toString();
                                  year = pickedDate.year
                                      .toString()
                                      .substring(2, 4);
                                });
                                //cartPro.setExpiryDate(pickedDate);
                              }
                            },
                            headerPadding: const EdgeInsets.only(left: 8),
                            Boardercolor: Colors.transparent,
                            color: Colors.grey,
                            hintColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: CustomTextFormFieldWithHeader(
                            headerText: "Security Code",
                            controller: _securityCode,
                            gradientBorder: true,
                            keyboardType: TextInputType.number,
                            inputFormatters:
                                LengthLimitingTextInputFormatter(3),
                            headerPadding: const EdgeInsets.only(left: 8),
                            Boardercolor: Colors.transparent,
                            color: Colors.grey,
                            hintColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            height: 23,
                            width: 23,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              shape: BoxShape.circle,
                            ),
                            child: const SizedBox(),
                          ),
                          CustomText(
                            text: "Save card for future checkout",
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    CustomElevatedButton(
                      title: 'Make Payment',
                      onTap: () {
                        _showConfirmationDialog(context);
                      },
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: "Your data is safe and secure.",
                        size: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Confirmation'),
          content: const Text(
              'Your order has been sent to the owner. Confirmation of your order will be done in a while.'),
          actions: <Widget>[
            Consumer2<PaymentProvider,CartProvider>(
           
              builder: (context,PaymentProvider paymentPro,CartProvider cartPro, snapshot) {
                return TextButton(
                  onPressed: () async {
                      final bool done = await paymentPro.productOrder(context: 
                                context, cart: cartPro.cartItem);
                                if(done){
              cartPro.deleteAllItem();
                   Navigator.of(context).pushReplacementNamed(MaineScreen.routeName);
                                }
                   // Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                );
              }
            ),
          ],
        );
      },
    );
  }

  BoxDecoration getBottomSheetDecoration = const BoxDecoration(
    borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black,
        offset: Offset(0.0, 0.0),
        blurRadius: 2.0,
      ),
    ],
  );
}

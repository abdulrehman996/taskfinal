import 'package:biz_link/database/product_api.dart';
import 'package:biz_link/models/product/product.dart';
import 'package:biz_link/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_category_provider.dart';
import '../../utility/custom_services.dart';
import '../../utility/custom_validators.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/custom_widgets/show_loading.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({required this.product, super.key});
  final Product product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _title;
  late TextEditingController _des;
  late TextEditingController _price;
  late TextEditingController _qty;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void initState() {
    _title = TextEditingController(text: widget.product.title);
    _des = TextEditingController(text: widget.product.description);
    _price = TextEditingController(text: widget.product.price.toString());
    _qty = TextEditingController(text: widget.product.quantity.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: GestureDetector(
        onTap: () {
          CustomService.dismissKeyboard();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _titleText('Title'.toUpperCase()),
                      CustomTextFormField(
                        controller: _title,
                        hint: 'Write product title here',
                        validator: (String? p0) =>
                            CustomValidator.lessThen2(p0),
                      ),
                      _titleText('Description'.toUpperCase()),
                      CustomTextFormField(
                        controller: _des,
                        minLines: 1,
                        maxLines: 5,
                        hint: 'Write something about product',
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        validator: (String? p0) => null,
                      ),
                      _titleText('Price'.toUpperCase()),
                      CustomTextFormField(
                        controller: _price,
                        hint: 'Select Price',
                        validator: (String? value) =>
                            CustomValidator.isEmpty(value),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textInputAction: TextInputAction.next,
                      ),
                      _titleText('Quantity'.toUpperCase()),
                      _qtyTextFormField(),
                      const SizedBox(height: 16),
                      const Text(
                        'Please note that all delivery must be track and signed for. Please keep that in account when deciding delivery fee.\nThank you.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _isLoading
                      ? const ShowLoading()
                      : CustomElevatedButton(
                          title: 'Update',
                          onTap: () async {
                            if (!_key.currentState!.validate()) return;
                            setState(() {
                              _isLoading = true;
                            });
                            widget.product.title = _title.text;
                            widget.product.description = _des.text;
                            widget.product.price =
                                double.tryParse(_price.text) ?? 0.0;
                            widget.product.quantity =
                                int.tryParse(_qty.text) ?? 0;
                            await ProductAPI().update(widget.product);
                            await Provider.of<ProductProvider>(context,
                                    listen: false)
                                .refresh();
                            Navigator.of(context).pop();
                          },
                        ),
                  _isLoading
                      ? const SizedBox()
                      : CustomElevatedButton(
                          title: 'Delete',
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await ProductAPI().delete(widget.product.pid);
                            await Provider.of<ProductProvider>(context,
                                    listen: false)
                                .refresh();
                            Navigator.of(context).pop();
                          },
                        ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _titleText(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        ' $title',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Row _qtyTextFormField() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            if (_qty.text.isEmpty) {
              _qty.text = '0';
              return;
            }
            int num = int.parse(_qty.text);

            if (num > 0) {
              num--;
              _qty.text = num.toString();
            }
          },
          splashRadius: 16,
          icon: Icon(
            Icons.remove_circle_outline,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: CustomTextFormField(
            controller: _qty,
            contentPadding: const EdgeInsets.only(left: 40),
            showPrefixIcon: false,
            validator: (String? value) => CustomValidator.isEmpty(value),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          onPressed: () {
            if (_qty.text.isEmpty) {
              _qty.text = '0';
            }
            int num = int.parse(_qty.text);
            num++;
            _qty.text = num.toString();
          },
          splashRadius: 16,
          icon: Icon(
            Icons.add_circle,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

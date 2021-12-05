import 'dart:io';

import 'package:biz_link/database/auth_methods.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../database/product_api.dart';
import '../../models/product/prod_category.dart';
import '../../models/product/prod_sub_category.dart';
import '../../models/product/product.dart';
import '../../models/product/product_url.dart';
import '../../providers/product_category_provider.dart';
import '../../utility/custom_services.dart';
import '../../utility/custom_validators.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../../widgets/custom_widgets/show_loading.dart';
import '../../widgets/product/prod_cat_dropdown.dart';
import '../../widgets/product/prod_sub_cat_dropdown.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const String routeName = '/add-product';
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _quantity = TextEditingController(text: '1');
  final TextEditingController _deliveryFee = TextEditingController(text: '0');
  bool _acceptOffer = true;
  bool _isloading = false;
  final List<PlatformFile?> _files = <PlatformFile?>[
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  ];

  void _reset() {
    _title.clear();
    _description.clear();
    _price.clear();
    _quantity.text = '1';
    _deliveryFee.text = '0';
    _files.clear();
    for (int i = 0; i < 10; i++) {
      _files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Selling'),
        centerTitle: false,
        elevation: 0,
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
              child: Consumer<ProdCatProvider>(
                builder: (
                  BuildContext context,
                  ProdCatProvider category,
                  _,
                ) =>
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    _GetProductImages(
                      onTap: () => _fetchMedia(),
                      file: _files,
                    ),
                    const SizedBox(height: 20),
                    _infoSection(category),
                    const SizedBox(height: 16),
                    _isloading
                        ? const ShowLoading()
                        : CustomElevatedButton(
                            title: 'Post',
                            onTap: () => _submitForm(category),
                          ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(ProdCatProvider category) async {
    if (_key.currentState!.validate()) {
      if (_files[0] == null) {
        CustomToast.errorToast(message: 'Add Images of the product');
        return;
      }
      CustomService.dismissKeyboard();
      setState(() {
        _isloading = true;
      });
      String pid = AuthMethods.uniqueID;

      List<ProductURL> urls = <ProductURL>[];
      for (int i = 0; i < 10; i++) {
        if (_files[i] != null) {
          String? tempURL = await ProductAPI().uploadImage(
            pid: pid,
            file: File(_files[i]!.path!),
          );
          urls.add(
            ProductURL(
              url: tempURL ?? '',
              isVideo: false,
              index: i,
            ),
          );
        }
      }
      Product product = Product(
        pid: pid,
        uid: AuthMethods.uid,
        title: _title.text.trim(),
        prodURL: urls,
        thumbnail: '',
        description: _description.text.trim(),
        categories: <String>[category.selectedCategroy!.catID],
        subCategories: <String>[category.selectedSubCategory!.catID],
        price: double.parse(_price.text),
        quantity: int.parse(_quantity.text.trim()),
        isAvailable: true,
        timestamp: DateTime.now().microsecondsSinceEpoch,
      );
      final bool uploaded = await ProductAPI().addProduct(product);
      setState(() {
        _isloading = false;
      });
      if (uploaded) {
        if (!mounted) return;
        // Provider.of<AppProvider>(context, listen: false).onTabTapped(0);
        // _reset();
        Navigator.of(context).pop();
        CustomToast.successToast(message: 'Uploaded Successfully');
      } else {
        CustomToast.errorToast(message: 'Error');
      }
    }
  }

  _fetchMedia() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );
    if (result == null) return;
    _files.clear();
    for (PlatformFile element in result.files) {
      // File mediaFile = File(element.path!);
      _files.add(element);
    }
    for (int i = result.files.length; i < 10; i++) {
      _files.add(null);
    }

    setState(() {});
  }

  Column _infoSection(ProdCatProvider category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _additionalInformation('Basic information'),
        _titleText('Title'.toUpperCase()),
        CustomTextFormField(
          controller: _title,
          hint: 'Write product title here',
          validator: (String? p0) => CustomValidator.lessThen2(p0),
        ),
        _titleText('Description'.toUpperCase()),
        CustomTextFormField(
          controller: _description,
          minLines: 1,
          maxLines: 5,
          hint: 'Write something about product',
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          validator: (String? p0) => null,
        ),
        _titleText('Category'.toUpperCase()),
        ProdCatDropdown(
          items: category.category,
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
          hintText: 'Select...',
          selectedItem: category.selectedCategroy,
          onChanged: (ProdCategory? update) {
            category.updateCatSelection(update!);
          },
        ),
        _titleText('Sub Category'.toUpperCase()),
        ProdSubCatDropdown(
          items: category.subCategory,
          color: Colors.grey[300],
          hintText: 'Select...',
          selectedItem: category.selectedSubCategory,
          onChanged: (ProdSubCategory? update) {
            category.updateSubCategorySection(update!);
          },
        ),
        _titleText('Price'.toUpperCase()),
        CustomTextFormField(
          controller: _price,
          hint: 'Select Price',
          validator: (String? value) => CustomValidator.isEmpty(value),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,
        ),
        _titleText('Quantity'.toUpperCase()),
        _quantityTextFormField(),
        const SizedBox(height: 16),
        const Text(
          'Please note that all delivery must be track and signed for. Please keep that in account when deciding delivery fee.\nThank you.',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Row _additionalInformation(String title) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        Text(
          '  $title  '.toUpperCase(),
          style: TextStyle(color: Colors.grey[400]),
        ),
        Flexible(
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  Row _quantityTextFormField() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            if (_quantity.text.isEmpty) {
              _quantity.text = '0';
              return;
            }
            int num = int.parse(_quantity.text);

            if (num > 0) {
              num--;
              _quantity.text = num.toString();
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
            controller: _quantity,
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
            if (_quantity.text.isEmpty) {
              _quantity.text = '0';
            }
            int num = int.parse(_quantity.text);
            num++;
            _quantity.text = num.toString();
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
}

class _GetProductImages extends StatefulWidget {
  const _GetProductImages({required this.file, required this.onTap, Key? key})
      : super(key: key);
  final List<PlatformFile?> file;
  final VoidCallback onTap;
  @override
  __GetProductImagesState createState() => __GetProductImagesState();
}

class __GetProductImagesState extends State<_GetProductImages> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 32 - 20;
    return Column(
      children: <Widget>[
        InkWell(
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            height: (width / 5) * 2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              color: Colors.grey[300],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(height: 16),
                Icon(Icons.add_circle_rounded),
                SizedBox(height: 6),
                Text('Add Images'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: width / 5,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 5),
            itemBuilder: (BuildContext context, int index) => _ImageBox(
              index: index + 1,
              width: width / 5,
              file: widget.file[index],
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: width / 5,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 5),
            itemBuilder: (BuildContext context, int index) => _ImageBox(
              index: index + 6,
              width: width / 5,
              file: widget.file[index + 5],
            ),
          ),
        ),
      ],
    );
  }
}

class _ImageBox extends StatelessWidget {
  const _ImageBox({
    required this.index,
    required double width,
    this.file,
    Key? key,
  })  : _width = width,
        super(key: key);

  final double _width;
  final int index;
  final PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _width,
      width: _width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: (file == null)
          ? Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey[300],
              child: FittedBox(
                child: Text(
                  index.toString(),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.08),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            )
          : SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.file(File(file!.path!)),
              // child: (Utilities.isVideo(extension: file!.extension!))
              //     ? AssetsVideoWidget(videoPath: file!.path!)
              //     : Image.file(File(file!.path!)),
            ),
    );
  }
}

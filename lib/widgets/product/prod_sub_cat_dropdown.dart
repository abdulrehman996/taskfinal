import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../models/product/prod_sub_category.dart';

class ProdSubCatDropdown extends StatelessWidget {
  const ProdSubCatDropdown({
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.borderRadius,
    this.color,
    this.hintText = 'Sub Category',
    this.margin,
    Key? key,
  }) : super(key: key);
  final List<ProdSubCategory> items;
  final ProdSubCategory? selectedItem;
  final BorderRadiusGeometry? borderRadius;
  final void Function(ProdSubCategory?) onChanged;
  final Color? color;
  final String hintText;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: margin ?? const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 201, 201, 201)),
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: DropdownSearch<ProdSubCategory>(
        showSearchBox: true,
        dropdownSearchTextAlignVertical: TextAlignVertical.center,
        mode: Mode.MENU,
        selectedItem: selectedItem,
        items: items,
        dropdownSearchBaseStyle: const TextStyle(color: Colors.white),
        itemAsString: (ProdSubCategory? item) => item!.title,
        onChanged: (ProdSubCategory? value) => onChanged(value),
        validator: (ProdSubCategory? value) {
          if (value == null) return 'Sub Category Required';
          return null;
        },
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

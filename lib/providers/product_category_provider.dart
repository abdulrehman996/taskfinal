import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../database/category_api.dart';
import '../../models/product/prod_category.dart';
import '../../models/product/prod_sub_category.dart';

class ProdCatProvider extends ChangeNotifier {
  ProdCatProvider() {
    _load();
  }

  _load() async {
    _cat.addAll(await CategoryAPI().getAll());
    notifyListeners();
  }

  ProdCategory? _selectedCat;
  List<ProdSubCategory> _subCategory = <ProdSubCategory>[];
  ProdSubCategory? _selectedSubCat;
  final List<ProdCategory> _cat = <ProdCategory>[];

  List<ProdCategory> get category => <ProdCategory>[..._cat];
  List<ProdSubCategory> get subCategory => <ProdSubCategory>[..._subCategory];
  ProdCategory? get selectedCategroy => _selectedCat;
  ProdSubCategory? get selectedSubCategory => _selectedSubCat;

  void updateCatSelection(ProdCategory updatedCategroy) {
    _selectedCat = updatedCategroy;
    _subCategory = updatedCategroy.subCategories;
    _selectedSubCat = null;
    notifyListeners();
  }

  void updateSubCategorySection(ProdSubCategory update) {
    _selectedSubCat = update;
    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'prod_sub_category.dart';

class ProdCategory {
  ProdCategory({
    required this.catID,
    required this.title,
    required this.subCategories,
    this.status = true,
  });

  String catID;
  final String title;
  final bool status;
  final List<ProdSubCategory> subCategories;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cat_id': catID,
      'title': title,
      'status': status,
      'sub_categories':
          subCategories.map((ProdSubCategory x) => x.toMap()).toList(),
    };
  }

  // ignore: sort_constructors_first
  factory ProdCategory.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<ProdSubCategory> subCats = <ProdSubCategory>[];
    // ignore: always_specify_types
    final List<dynamic> data = doc.data()?['sub_categories'] ?? [];
    for (dynamic element in data) {
      subCats.add(ProdSubCategory.fromMap(element));
    }
    return ProdCategory(
      catID: doc.data()?['cat_id']?.toString().trim() ?? '',
      title: doc.data()?['title']?.toString().trim() ?? '',
      status: doc.data()?['status'] ?? true,
      subCategories: subCats,
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product/prod_category.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class CategoryAPI {
  static const String _colloction = 'categories';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<List<ProdCategory>> getAll() async {
    final List<ProdCategory> cats = <ProdCategory>[];
    try {
      final QuerySnapshot<Map<String, dynamic>> docs =
          await _instance.collection(_colloction).orderBy('title').get();
      for (DocumentSnapshot<Map<String, dynamic>> element in docs.docs) {
        final ProdCategory cat = ProdCategory.fromDoc(element);
        cats.add(cat);
      }
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
    return cats;
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:biz_link/functions/time_date_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/product/product.dart';
import 'auth_methods.dart';

class ProductAPI {
  static const String _collection = 'products';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  // functions
  Future<Product?>? getProductByPID({required String pid}) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).doc(pid).get();
    if (doc.data() == null) return null;
    return Product.fromDoc(doc);
  }

  Future<List<Product>> getProductsByUID({required String uid}) async {
    List<Product> products = <Product>[];
    final QuerySnapshot<Map<String, dynamic>> doc = await _instance
        .collection(_collection)
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      products.add(Product.fromDoc(element));
    }
    return products;
  }

  Future<List<Product>> getProducts() async {
    List<Product> products = <Product>[];
    final QuerySnapshot<Map<String, dynamic>> doc = await _instance
        .collection(_collection)
        .orderBy('timestamp', descending: true)
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      products.add(Product.fromDoc(element));
    }
    return products;
  }

  Future<bool> addProduct(Product product) async {
    try {
      // ignore: always_specify_types
      await _instance
          .collection(_collection)
          .doc(product.pid)
          .set(product.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(Product product) async {
    try {
      // ignore: always_specify_types
      await _instance
          .collection(_collection)
          .doc(product.pid)
          .update(product.update());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String value) async {
    try {
      // ignore: always_specify_types
      await _instance.collection(_collection).doc(value).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> uploadImage({required String pid, required File file}) async {
    try {
      log('Start Uploading image PATH SET...');
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('products')
          .child(AuthMethods.uid)
          .child(pid)
          .child(TimeDateFunctions.timestamp.toString());

      UploadTask uploadTask = ref.putFile(file);
      log('Start Uploading image SERVER UPLOAD...');
      TaskSnapshot snap = await uploadTask;
      String downloadurl = await snap.ref.getDownloadURL();
      log('Done Uploading URL: $downloadurl');
      return downloadurl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

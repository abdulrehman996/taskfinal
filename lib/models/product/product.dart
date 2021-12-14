import 'package:biz_link/enums/role.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'product_url.dart';

class Product {
  Product({
    required this.pid,
    required this.uid,
    required this.title,
    required this.prodURL,
    required this.description,
    required this.categories,
    required this.subCategories,
    required this.sellTo,
    required this.price,
    this.location,
    this.quantity = 1,
    this.timestamp,
    this.isAvailable = true,
  });

  late String pid;
  late String uid;
  late String title;
  late List<ProductURL> prodURL;
  late String description;
  late List<String> categories;
  late List<String> subCategories;
  final List<String> sellTo;
  late double price;
  late String? location;
  late int quantity;
  late int? timestamp;
  late bool isAvailable; // available for sale any more are not

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'uid': uid,
      'title': title,
      'prodURL': prodURL.map((ProductURL e) => e.toMap()).toList(),
      'description': description,
      'categories': categories,
      'sell_to': sellTo,
      'sub_categories': subCategories,
      'price': price,
      'quantity': quantity,
      'timestamp': timestamp,
      'is_available': isAvailable,
    };
  }

  Map<String, dynamic> update() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }

  // ignore: sort_constructors_first
  factory Product.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<ProductURL> prodURL = <ProductURL>[];
    doc.data()?['prodURL'].forEach((dynamic e) {
      prodURL.add(ProductURL.fromMap(e));
    });
    return Product(
      pid: doc.data()?['pid'] ?? '',
      uid: doc.data()?['uid'] ?? '',
      title: doc.data()?['title'] ?? '',
      prodURL: prodURL,
      description: doc.data()?['description'] ?? '',
      categories: List<String>.from(doc.data()?['categories'] ?? []),
      subCategories: List<String>.from(doc.data()?['sub_categories'] ?? []),
      sellTo: List<String>.from(doc.data()?['sell_to'] ?? [Role.retailer.json]),
      price: doc.data()?['price']?.toDouble() ?? 0.0,
      location: doc.data()?['location'] ?? 'location not found',
      quantity: doc.data()?['quantity']?.toInt() ?? 0,
      timestamp: doc.data()?['timestamp']?.toInt(),
      isAvailable: doc.data()?['is_available'] ?? false,
    );
  }
}

import 'package:biz_link/providers/product_provider.dart';
import 'package:biz_link/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/auth_methods.dart';
import '../database/order_api.dart';
import '../database/transaction_api.dart';
import '../functions/unique_id_functions.dart';
import '../models/app_user.dart';
import '../models/cart.dart';
import '../models/product/my_order.dart';
import '../models/product/order_product.dart';
import '../models/product/product.dart';
import '../models/product/transaction.dart';
import '../utility/time_date_fun.dart';

class PaymentProvider with ChangeNotifier{
  void load() async{
    _allOrder.clear();
    _order.clear();
    List<MyOrder> tempOrder = <MyOrder>[];
    tempOrder = await OrderApi().get();
    for (int i = 0; i < tempOrder.length; i++) {
      if (AuthMethods.uid == tempOrder[i].customerUID) {
        _order.add(tempOrder[i]);
      }
    }
    _allOrder = tempOrder;
     sellProductFun();
  }
  void sellProductFun() {
    sellProducts.clear();
    sellingOrder.clear();
    for (int i = 0; i < allOrder.length; i++) {
      //print(allOrder[i].orderID);
      for (int j = 0; j < allOrder[i].products.length; j++) {
        // print(allOrder[i].products[j].sellerID);
        // print(AuthMethods.uid);
        if (AuthMethods.uid == allOrder[i].products[j].sellerID) {
          sellProducts.add(allOrder[i].products[j]);
          sellingOrder.add(allOrder[i]);
          print(allOrder[i].products[j].sellerID);
        }
      }
    }
    print(sellProducts.length);
  }
  bool isLoading=false;
  final List<OrderdProduct> _orderProduct = <OrderdProduct>[];
  List<OrderdProduct> get orderdProduct => _orderProduct;
  Future<bool> productOrder({
  required   BuildContext context,
    required List<Cart> cart,
 } ) async {
    isLoading=true;
    notifyListeners();
    String uniqueID = UniqueIdFunctions.postID;
    bool retBool = false;
    double total = 0;
    for (int i = 0; i < cart.length; i++) {
      OrderdProduct tempOrderProduct = OrderdProduct(
        pid: cart[i].id,
        sellerID: cart[i].sellerID,
       
        quantity: cart[i].quantity, amount: cart[i].price,
      );
      total += cart[i].price * cart[i].quantity;
      _orderProduct.add(tempOrderProduct);
    }
    MyOrder tempOrder = MyOrder(
      orderID: uniqueID,
      receiptID: uniqueID,
      sellerUID: _orderProduct[0].sellerID,
      customerUID: AuthMethods.uid,
      timestamp: TimeStamp.timestamp,
      products: _orderProduct,
    );
   
    Transactions tempTransaction = Transactions(
      transactionID: uniqueID,
      products: _orderProduct,
      orderID: uniqueID,
      customerUID: AuthMethods.uid,
      sellerUID: _orderProduct[0].sellerID,
      totalPrice: total,
      timeStamp: TimeStamp.timestamp,
     
    );
  
    final UserProvider userPro =
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false);
    final ProductProvider productPro =
        Provider.of<ProductProvider>(context, listen: false);
    final AppUser sender = userPro.user(uid:AuthMethods.uid);
    
    final List<Product> productList = [];
    for (int i = 0; i < cart.length; i++) {
      final Product temp = productPro.product(cart[i].id);
      productList.add(temp);
    }
    final bool orderBool = await OrderApi().add(
        order: tempOrder,
     );
    
    final bool transactionBool = await TransactionApi().add(tempTransaction);
    orderdProduct.clear();
    isLoading=true;
    notifyListeners();
    if (orderBool && transactionBool) {
      return true;
    }
    return false;
  }
  List<MyOrder> _allOrder = <MyOrder>[];
  List<MyOrder> get allOrder => _allOrder;
  final List<MyOrder> _order = <MyOrder>[];
  List<MyOrder> get order => _order;
final List<OrderdProduct> _sellProduct = <OrderdProduct>[];
  List<OrderdProduct> get sellProducts => _sellProduct;
  final List<MyOrder> _sellingOrder = <MyOrder>[];
  List<MyOrder> get sellingOrder => _sellingOrder;
}
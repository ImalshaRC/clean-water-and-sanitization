import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/Order.dart';

class OrderService{

  Future createOrder( String uid, {
    required String name,
    required String address,
    required String mobile,
    required String productName,
    required String qty,
    required String totalPrice,
    required String state,
  }) async{
    try{
      final docOrder = FirebaseFirestore.instance.collection('orders').doc(uid).set({
        'uid': uid,
        'name': name,
        'address': address,
        'mobile': mobile,
        'productName': productName,
        'qty': qty,
        'totalPrice': totalPrice,
        'state': state
      });

      print(docOrder);

      // final order = Orders(
      //     id: docOrder.id,
      //     name: name,
      //     address: address,
      //     mobile: mobile,
      //     productName: productName,
      //     qty: qty,
      //     totalPrice: totalPrice,
      //     state: state
      // );
      // final json = order.toJson();
      //
      // await docOrder.set(json);

      return 'Success';

    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }
  }
}

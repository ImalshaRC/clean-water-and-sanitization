import 'package:clear_water_and_sanitization/screens/Home/BuyAProduct/orderlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/Order.dart';


class TrackOrder extends StatefulWidget {

  final String userId;

  const TrackOrder(this.userId, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<TrackOrder> createState() => _TrackOrderState(userId);
}

class _TrackOrderState extends State<TrackOrder> {

  String userId;
  final nameController = TextEditingController();
  final qtyController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final priceController = TextEditingController();
  final stateController = TextEditingController();

  _TrackOrderState(this.userId);

  late Orders orderData;
  late DocumentReference<Map<String, dynamic>> singleOrder;
  final double textBorder = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title:  const Text("Track Order"),
        actions: [
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:  <Widget> [
          const SizedBox(height: 40),
          TextField(
            enabled: false,
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Product Name',
              labelText: 'Product Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 20),
          TextField(
            enabled: false,
            controller: addressController,
            decoration: InputDecoration(
              hintText: 'Address',
              labelText: ' Home Address',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            enabled: false,
            controller: mobileController,
            decoration: InputDecoration(
              hintText: 'Mobile Number',
              labelText: 'Mobile Number',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            enabled: false,
            controller: qtyController,
            decoration: InputDecoration(
              hintText: 'Quantity',
              labelText: 'Quantity',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 24),
          TextField(
            enabled: false,
            controller: priceController,
            decoration: InputDecoration(
              hintText: 'Total Price',
              labelText: 'Total Price',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            enabled: false,
            controller: stateController,
            decoration: InputDecoration(
              hintText: 'State',
              labelText: 'Current State',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => alertBox(),
              );
            },
            child: const Text('Delete Order',),
          ),
        ],
      ),
    );
  }

  alertBox<Widget>() {
    return AlertDialog(
      title: const Text("Do you want to delete?"),
      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("No")
        ),
        ElevatedButton(
            onPressed: (){
              deleteUser();
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const OrderList();
              }));
            },
            child: const Text("Yes")
        )
      ],
    );
  }

  @override
  void initState() {
    readUser();
    super.initState();
  }

  readUser() async{
    singleOrder = FirebaseFirestore.instance.collection('orders').doc(userId);

    final DocumentSnapshot<Map<String, dynamic>> snapshot;

    try{
      snapshot  = await singleOrder.get();

      if(snapshot.exists){
        orderData = Orders.fromJson(snapshot.data()!);
        nameController.text = orderData.productName;
        addressController.text = orderData.address;
        mobileController.text = orderData.mobile;
        qtyController.text = orderData.qty;
        priceController.text = 'Rs.'+orderData.totalPrice+'.00';
        stateController.text = orderData.state;
      }else{
        if (kDebugMode) {
          print("No data found");
        }
      }
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  // Future<dynamic> updateDonation({
  //   required String name,
  //   required String address,
  //   required String mobile,
  //   required String liter,
  //   required String phi,
  // }) async{
  //   final updatedDonation = Orders(
  //     id: singleOrder.id,
  //     name: name,
  //     address: address,
  //     mobile: mobile,
  //     totalPrice: ,
  //     state: state,
  //   );
  //
  //   final json = updatedDonation.toJson();
  //
  //   try{
  //     await singleDonation.update(json);
  //   }catch(err){
  //     if (kDebugMode) {
  //       print(err.toString());
  //     }
  //   }
  // }

  Future<dynamic> deleteUser() async{
    try{
      await singleOrder.delete();
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }
}



import 'package:clear_water_and_sanitization/models/Order.dart';
import 'package:clear_water_and_sanitization/services/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/SingleUser.dart';
import '../home.dart';

class Checkout extends StatefulWidget {



  final SingleUser singleUser;
  final int price;
  final String name;
  final String qty;

  const Checkout(this.singleUser, {Key? key, required this.price, required this.name, required this.qty}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  final OrderService _order = OrderService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final nameControl = TextEditingController();
  final addressControl = TextEditingController();
  final phoneControl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    nameControl.text =
    '${widget.singleUser.firstName} ${widget.singleUser.lastName}';
    addressControl.text = widget.singleUser.address;
    phoneControl.text = widget.singleUser.phoneNo;

    int? quantity = int.tryParse(widget.qty);
    String qty3 = quantity.toString();

    int ? totalQuantity = (widget.price! * quantity!)!;
    String totalPrice = totalQuantity.toString();


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0.0,
          title: const Text('Checkout'),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                Text("Item Name", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25)),
                Text('Qty',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  child: Text(
                      widget.name.toString(), style: TextStyle(fontSize: 25)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 30.0, 50.0, 0.0),
                    child: Text(qty3, style: TextStyle(fontSize: 25))),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  child: Text('Total', style: TextStyle(fontSize: 25)),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                    child: Text(totalPrice, style: TextStyle(fontSize: 25))
                )

              ],),
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
              child: Column(

                children: <Widget>[
                  TextField(
                    controller: nameControl,
                    decoration: const InputDecoration(
                        hintText: 'Enter your full name', labelText: 'Name'),
                    keyboardType: TextInputType.text,
                  ),
                  TextField(
                    controller: addressControl,
                    decoration: const InputDecoration(
                        hintText: 'Enter your address', labelText: 'Address'),
                    keyboardType: TextInputType.text,
                  ),
                  TextField(
                    controller: phoneControl,
                    decoration: const InputDecoration(
                        hintText: 'Enter your phone number',
                        labelText: 'Phone Number'),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
              child: ElevatedButton(
                onPressed: () async {

                  final userId =  _auth.currentUser?.uid;

                  dynamic result = _order.createOrder(
                      name: '${widget.singleUser.firstName} ${widget.singleUser
                          .lastName}',
                      address: widget.singleUser.address,
                      mobile: widget.singleUser.phoneNo,
                      productName: widget.name.toString(),
                      qty: qty3,
                      totalPrice: totalPrice,
                      state: 'Processing',userId!);

                    print('Successfully Created Order');
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Successfully Created Order'),
                        ));
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const Home()));

                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.cyan
                ),
                child: const Text('Order Items',
                  style: TextStyle(fontSize: 20),),
              ),),

          ],
        )
    );
  }
}


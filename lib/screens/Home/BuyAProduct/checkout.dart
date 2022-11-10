import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/SingleUser.dart';

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

  final nameControl = TextEditingController();
  final addressControl = TextEditingController();
  final phoneControl = TextEditingController();




  @override
  Widget build(BuildContext context) {

    nameControl.text = '${widget.singleUser.firstName} ${widget.singleUser.lastName}';
    addressControl.text = widget.singleUser.address;
    phoneControl.text = widget.singleUser.phoneNo;

    int? quantity = int.tryParse(widget.qty);
    String qty3 = quantity.toString();

    int ? totalQuantity = (widget.price! * 3)!;
    String totalQty = totalQuantity.toString();


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0.0,
        title: const Text('Checkout'),
    ),
    body:Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:const <Widget> [
            Text("Item Name"),
            Text('Qty')
          ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Text(widget.name.toString()),
            Text(qty3)
          ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Text('Total'),
            Text(totalQty)
          ],),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
          child: Column(

            children: <Widget>[
              TextField(
                controller: nameControl,
                decoration: const InputDecoration(hintText: 'Enter your full name', labelText: 'Name'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: addressControl,
                decoration: const InputDecoration(hintText: 'Enter your address', labelText: 'Address'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: phoneControl,
                decoration: const InputDecoration(hintText: 'Enter your phone number', labelText: 'Phone Number'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
          child: ElevatedButton(
            onPressed: () async {
              // Navigator.push(context, MaterialPageRoute(builder: (_)=> Checkout(singleUser)));
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

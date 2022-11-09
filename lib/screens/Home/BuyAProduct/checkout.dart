import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/SingleUser.dart';

class Checkout extends StatefulWidget {

  final SingleUser singleUser;

  const Checkout(this.singleUser, {Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0.0,
        title: const Text('Checkout'),
    ),
    body:Container(
      child: Text('Checkout'),
    )
    );
  }
}

import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0.0,
        title: const Text('Order List'),
    ),
    );
  }
}

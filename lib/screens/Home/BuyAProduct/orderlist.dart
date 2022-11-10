import 'package:clear_water_and_sanitization/models/Order.dart';
import 'package:clear_water_and_sanitization/screens/Home/BuyAProduct/categories.dart';
import 'package:clear_water_and_sanitization/screens/Home/BuyAProduct/trackorder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../DonationHandling/UpdateDonation.dart';

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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const Categories();
                }));
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
      body: StreamBuilder<List<Orders>>(
        stream: readDonations(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final users = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              children: users.map(buildUser).toList(),
            );
          }else if(snapshot.hasError){
            if (kDebugMode) {
              print('Error --> ${snapshot.error}');
            }
            return const Center(
              child: Text("Oops Something Went Wrong..."),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(Orders order) {

    var borderRadius = const BorderRadius.all(Radius.circular(18));
    const double ft = 19;

    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          selectedTileColor: Colors.blueAccent,
          selected: true,
          title: Column(
            children: [
              Row(
                children: [
                  const SizedBox(height: 7),
                  Text(
                      order.productName,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                  const Spacer(),
                  Text(
                      order.state,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 23),
              Row(
                children: [
                  Text(
                      'Total Price: Rs.${order.totalPrice}.00',
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) => alertBox(order.id),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          backgroundColor: Colors.red
                      ),
                      child: const Text("Delete")
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return TrackOrder(order.id);
            }));
          },
        )
      ],
    );
  }

  alertBox<Widget>(String id) {
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
              deleteUser(id);
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const OrderList();
              }));
            },
            child: const Text("Yes")
        )
      ],
    );
  }

  Future<dynamic> deleteUser(userId) async{
    var singleOrder = FirebaseFirestore.instance.collection('orders').doc(userId);
    try{
      await singleOrder.delete();
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  Stream<List<Orders>> readDonations() => FirebaseFirestore.instance
      .collection('orders')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) =>
          Orders.fromJson(doc.data()),
      ).toList(),
  );
}

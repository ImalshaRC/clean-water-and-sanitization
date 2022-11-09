import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationList extends StatefulWidget {
  const DonationList({Key? key}) : super(key: key);

  @override
  State<DonationList> createState() => _UserListState();
}

class _UserListState extends State<DonationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (_){
                //   return const CrudApp();
                // }));
              },
              icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.qr_code),
          ),
        ],
      ),
      body: StreamBuilder<List<WaterDonation>>(
        stream: readUsers(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final users = snapshot.data!;
            return ListView(
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

  Widget buildUser(WaterDonation user) => ListTile(
    leading: CircleAvatar(
      child: Text('${user.age} Years'),
    ),
    title: Text(user.name),
    subtitle: Text(user.birthday),
    onTap: () {
      // Navigator.of(context).push(MaterialPageRoute(builder: (_){
      //   return UpdateUser(user.id);
      // }));
    },
  );

  Stream<List<WaterDonation>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) =>
              WaterDonation.fromJson(doc.data()),
          ).toList(),
      );
}

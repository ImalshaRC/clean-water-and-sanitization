import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/AddDonation.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/UpdateDonation.dart';
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
        title: const Text("Water Donation List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const AddDonation();
                }));
              },
              icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<WaterDonation>>(
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

  Widget buildUser(WaterDonation user) {

    var borderRadius = const BorderRadius.all(Radius.circular(25));

    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
        leading: Column(

        ),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        selectedTileColor: Colors.grey,
        selected: true,
        title: Text(user.name),
        subtitle: Text(user.mobile),
        onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return UpdateDonation(user.id);
        }));
        },
        )
      ],
    );
  }

  Stream<List<WaterDonation>> readDonations() => FirebaseFirestore.instance
      .collection('waterDonation')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) =>
              WaterDonation.fromJson(doc.data()),
          ).toList(),
      );
}

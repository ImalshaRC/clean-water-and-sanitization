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
        backgroundColor: Colors.cyan,
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

  Widget buildUser(WaterDonation donation) {

    var borderRadius = const BorderRadius.all(Radius.circular(18));
    const double ft = 19;

    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          selectedTileColor: Colors.grey,
          selected: true,
          title: Column(
            children: [
              Row(
                children: [
                  const SizedBox(height: 7),
                  Text(
                      donation.name,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                  const Spacer(),
                  Text(
                      donation.mobile,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 23),
              Row(
                children: [
                  Text(
                    '${donation.liter} Liters',
                    style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return UpdateDonation(donation.id);
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        backgroundColor: Colors.cyan
                      ),
                      child: const Text("Update")
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) => alertBox(donation.id),
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
              return UpdateDonation(donation.id);
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
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan
            ),
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("No")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
            ),
            onPressed: (){
              deleteUser(id);
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const DonationList();
              }));
            },
            child: const Text("Yes")
        )
      ],
    );
  }

  Future<dynamic> deleteUser(userId) async{
    var singleDonation = FirebaseFirestore.instance.collection('waterDonation').doc(userId);
    try{
      await singleDonation.delete();
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
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

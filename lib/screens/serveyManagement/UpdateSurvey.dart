import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/DonationList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UpdateDonation extends StatefulWidget {

  final String userId;

  const UpdateDonation(this.userId, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<UpdateDonation> createState() => _UpdateUserState(userId);
}

class _UpdateUserState extends State<UpdateDonation> {

  String userId;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final literController = TextEditingController();
  final phiController = TextEditingController();

  _UpdateUserState(this.userId);

  late WaterDonation donationData;
  late DocumentReference<Map<String, dynamic>> singleDonation;
  final double textBorder = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Update Donation"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){

            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:  <Widget> [
          const SizedBox(height: 40),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Name',
              labelText: 'Enter Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              hintText: 'Age',
              labelText: 'Enter Home Address',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: mobileController,
            decoration: InputDecoration(
              hintText: 'Birth Date',
              labelText: 'Enter Mobile Number',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: literController,
            decoration: InputDecoration(
              hintText: 'Birth Date',
              labelText: 'Enter Number of Liters(L)',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: phiController,
            decoration: InputDecoration(
              hintText: 'Birth Date',
              labelText: 'Enter PHI Officer Mobile Number',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              shadowColor: Colors.blueAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              minimumSize: const Size(50, 50),
            ),
            onPressed: () {
              Navigator.pop(context);
              updateDonation(
                  name: nameController.text,
                  address: addressController.text,
                  mobile: mobileController.text,
                  liter: literController.text,
                  phi: phiController.text,
              );
            },
            child: const Text('Update Donation', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 24),
          // ElevatedButton(
          //   onPressed: () {
          //     showDialog(
          //         context: context,
          //         builder: (context) => alertBox(),
          //     );
          //   },
          //   child: const Text('Delete Donation'),
          // ),
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
                return const DonationList();
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
    singleDonation = FirebaseFirestore.instance.collection('waterDonation').doc(userId);

    final DocumentSnapshot<Map<String, dynamic>> snapshot;

    try{
      snapshot  = await singleDonation.get();

      if(snapshot.exists){
        donationData = WaterDonation.fromJson(snapshot.data()!);
        nameController.text = donationData.name;
        addressController.text = donationData.address;
        mobileController.text = donationData.mobile;
        literController.text = donationData.liter;
        phiController.text = donationData.phi;
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

  Future<dynamic> updateDonation({
    required String name,
    required String address,
    required String mobile,
    required String liter,
    required String phi,
  }) async{
    final updatedDonation = WaterDonation(
        id: singleDonation.id,
        name: name,
        address: address,
        mobile: mobile,
        liter: liter,
        phi: phi,
    );

    final json = updatedDonation.toJson();

    try{
      await singleDonation.update(json);
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  Future<dynamic> deleteUser() async{
    try{
      await singleDonation.delete();
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }
}


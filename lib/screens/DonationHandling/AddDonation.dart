import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDonation extends StatefulWidget {
  const AddDonation({Key? key}) : super(key: key);

  @override
  State<AddDonation> createState() => _CrudAppState();
}

class _CrudAppState extends State<AddDonation> {

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final literController = TextEditingController();
  final phiController = TextEditingController();
  final double textBorder = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add donation"),
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
              ElevatedButton(style: ElevatedButton.styleFrom(
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
                createDonation(
                  name: nameController.text,
                  address: addressController.text,
                  mobile: mobileController.text,
                  liter: literController.text,
                  phi: phiController.text,
                );
              },
              child: const Text('Create User', style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }

  Future<dynamic> createDonation({
    required String name,
    required String address,
    required String mobile,
    required String liter,
    required String phi
  }) async{
    final docWaterDonation = FirebaseFirestore.instance.collection('waterDonation').doc();

    final waterDonate = WaterDonation(
        id: docWaterDonation.id,
        name: name,
        address: address,
        mobile: mobile,
        liter: liter,
        phi: phi
    );

    final json = waterDonate.toJson();

    await docWaterDonation.set(json);
  }
}


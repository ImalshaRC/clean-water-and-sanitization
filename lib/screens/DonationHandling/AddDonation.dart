import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/DonationList.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/FeedbackList.dart';
import 'package:clear_water_and_sanitization/screens/Home/home.dart';
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
        backgroundColor: Colors.cyan,
        title: const Text("Add donation"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const Home();
              }));
            },
            icon: const Icon(Icons.home),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:  <Widget> [
          const Center(child: Text('Add Donation', style: TextStyle(fontSize: 28, color: Colors.blueAccent),)),
          const SizedBox(height: 40),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Enter Name',
              labelText: 'Enter Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              hintText: 'Enter Home Address',
              labelText: 'Enter Home Address',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: mobileController,
            decoration: InputDecoration(
              hintText: 'Enter Mobile Number',
              labelText: 'Enter Mobile Number',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: literController,
            decoration: InputDecoration(
              hintText: 'Enter Number of Liters(L)',
              labelText: 'Enter Number of Liters(L)',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: phiController,
            decoration: InputDecoration(
              hintText: 'Enter PHI Officer Mobile Number',
              labelText: 'Enter PHI Officer Mobile Number',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                onPrimary: Colors.white,
                shadowColor: Colors.blueAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                minimumSize: const Size(50, 50),
              ),
              onPressed: () {
                createDonation(
                  name: nameController.text,
                  address: addressController.text,
                  mobile: mobileController.text,
                  liter: literController.text,
                  phi: phiController.text,
                );
              },
              child: const Text('Add Donation', style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }

  showMessage(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  goToPage(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const DonationList();
    }));
  }

  Future<dynamic> createDonation({
    required String name,
    required String address,
    required String mobile,
    required String liter,
    required String phi
  }) async{
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    String pattern2 = r'\d';
    RegExp regExp2 = RegExp(pattern2);

    if(name == '' || address == '' || mobile == '' || liter == '' || phi == ''){

      showMessage('Please fill Out Required Fields');

    }if(!regExp.hasMatch(mobile)){
      showMessage('Please enter valid mobile number');
    }if(!regExp2.hasMatch(liter)){
      showMessage('Please enter valid Liter');
    }if(!regExp.hasMatch(phi)){
      showMessage('Please enter valid PHI mobile number');
    }else{
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

      showMessage('Donation Added Successfully');

      goToPage();
    }
  }
}


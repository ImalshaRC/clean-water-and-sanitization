import 'package:clear_water_and_sanitization/models/ArticleModel.dart';
import 'package:clear_water_and_sanitization/screens/Awareness/ArticlesFeed.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddArticle extends StatefulWidget {
  const AddArticle({Key? key}) : super(key: key);

  @override
  State<AddArticle> createState() => _CrudAppState();
}

class _CrudAppState extends State<AddArticle> {

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
        title: const Text("Add Article"),
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
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const ArticlesFeed();
                }));
                createDonation(
                  name: nameController.text,
                  address: addressController.text,
                  mobile: mobileController.text,
                  liter: literController.text,
                  phi: phiController.text,
                );
              },
              child: const Text('Add Article', style: TextStyle(fontSize: 18)),
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
    final docArticle = FirebaseFirestore.instance.collection('article').doc();

    final article = ArticleModel(
        id: docArticle.id,
        name: name,
        address: address,
        mobile: mobile,
        liter: liter,
        phi: phi
    );

    final json = article.toJson();

    await docArticle.set(json);
  }
}


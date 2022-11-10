import 'package:clear_water_and_sanitization/models/ArticleModel.dart';
import 'package:clear_water_and_sanitization/screens/Articles/ArticlesFeed.dart';
import 'package:clear_water_and_sanitization/screens/Articles/ArticlesList.dart';
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
          Center(child: Text("Create an Article")),
          const SizedBox(height: 40),
          Text("Article Heading"),
          const SizedBox(height: 10),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Article Heading',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 20),
          Text("Article Description"),
          const SizedBox(height: 10),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Description',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
          ),
          const SizedBox(height: 24),
          Text("Date"),
          const SizedBox(height: 10),
          TextField(
            controller: mobileController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Date',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          Text("Time"),
          const SizedBox(height: 10),
          TextField(
            controller: literController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Time',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          Text("Author's Name"),
          const SizedBox(height: 10),
          TextField(
            controller: phiController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Author Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.text,
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
                  return const ArticleList();
                }));
                createDonation(
                  name: nameController.text,
                  address: addressController.text,
                  mobile: mobileController.text,
                  liter: literController.text,
                  phi: phiController.text,
                );
              },
              child: const Text('Publish Article', style: TextStyle(fontSize: 18)),
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


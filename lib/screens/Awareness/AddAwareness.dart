import 'package:clear_water_and_sanitization/models/Awareness.dart';
import 'package:clear_water_and_sanitization/screens/Articles/ArticlesFeed.dart';
import 'package:clear_water_and_sanitization/screens/Awareness/AwarenessList.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAwareness extends StatefulWidget {
  const AddAwareness({Key? key}) : super(key: key);

  @override
  State<AddAwareness> createState() => _CrudAppState();
}

class _CrudAppState extends State<AddAwareness> {

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final typeController = TextEditingController();
  final venueController = TextEditingController();
  final double textBorder = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Awareness Session"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:  <Widget> [
          Center(child: Text("Arrange a Session")),
          const SizedBox(height: 40),
          Text("Session Topic / Name"),
          const SizedBox(height: 10),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Session Topic',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 20),
          Text("Description About this Session"),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
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
            controller: dateController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Date',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          const Text("Time"),
          const SizedBox(height: 10),
          TextField(
            controller: timeController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Time',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          Text("Meeting Type"),
          const SizedBox(height: 10),
          TextField(
            controller: typeController,
            decoration: InputDecoration(
              hintText: 'Online / Physical',
              labelText: 'Enter Meeting Type',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          Text("Meeting Link / Venue"),
          const SizedBox(height: 10),
          TextField(
            controller: venueController,
            decoration: InputDecoration(
              hintText: 'Meeting Link / Venue',
              labelText: 'Enter Meeting Link / Venue',
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
                  return const AwarenessList();
                }));
                createAwareness(
                  name: nameController.text,
                  description: descriptionController.text,
                  date: '10/11/2022',
                  time: '12.30 ',
                  type: typeController.text,
                  venue: venueController.text,
                );
              },
              child: const Text('Create', style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }

  Future<dynamic> createAwareness({
    required String name,
    required String description,
    required String date,
    required String time,
    required String type,
    required String venue
  }) async{
    final docAwreness = FirebaseFirestore.instance.collection('awareness').doc();

    final article = AwarenessModel(
        id: docAwreness.id,
        name: name,
        description: description,
        date: date,
        time: time,
        type: type,
        venue: venue
    );

    final json = article.toJson();

    await docAwreness.set(json);
  }
}


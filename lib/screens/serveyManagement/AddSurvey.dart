import 'package:clear_water_and_sanitization/models/SurveyFModel.dart';
import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSurvey extends StatefulWidget {
  const AddSurvey({Key? key}) : super(key: key);

  @override
  State<AddSurvey> createState() => _CrudAppState();
}

class _CrudAppState extends State<AddSurvey> {

  final provinceController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final problemController = TextEditingController();
  final descriptionController = TextEditingController();
  final populationController = TextEditingController();
  final familiesController = TextEditingController();
  final double textBorder = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Survey"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:  <Widget> [
          const SizedBox(height: 40),
          TextField(
            controller: provinceController,
            decoration: InputDecoration(
              hintText: 'province',
              labelText: 'Enter province',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: districtController,
            decoration: InputDecoration(
              hintText: 'District',
              labelText: 'Enter District',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: cityController,
            decoration: InputDecoration(
              hintText: 'City',
              labelText: 'Enter City',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: problemController,
            decoration: InputDecoration(
              hintText: 'Problem',
              labelText: 'Enter problem',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: 'Description',
              labelText: 'Enter description',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: populationController,
            decoration: InputDecoration(
              hintText: 'Population',
              labelText: 'Enter population',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: familiesController,
            decoration: InputDecoration(
              hintText: 'Number of Families',
              labelText: 'Enter No. families',
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
                createSurvey(
                  province: provinceController.text,
                  district: districtController.text,
                  city: cityController.text,
                  problem: problemController.text,
                  description: descriptionController.text,
                  population: populationController.text,
                  families: familiesController.text,
                );
              },
              child: const Text('Add Donation', style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }

  Future<dynamic> createSurvey({
    required String province,
    required String district,
    required String city,
    required String problem,
    required String description,
    required String population,
    required String families
  }) async{
    final docSurvey = FirebaseFirestore.instance.collection('docSurvey').doc();

    final surveyFModel = SurveyFModel (
        id: docSurvey.id,
        district: district,
        province: province,
        city: city,
        problem: problem,
        description: description,
        population: population,
        families: families
    );

    final json = surveyFModel.toJson();

    await docSurvey.set(json);
  }
}


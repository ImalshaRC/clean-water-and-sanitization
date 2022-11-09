import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudApp extends StatefulWidget {
  const CrudApp({Key? key}) : super(key: key);

  @override
  State<CrudApp> createState() => _CrudAppState();
}

class _CrudAppState extends State<CrudApp> {

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crud App"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:  <Widget> [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Name', labelText: 'Name'),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: ageController,
            decoration: const InputDecoration(hintText: 'Age', labelText: 'Age'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(hintText: 'Birth Date', labelText: 'Birth date'),
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                createUser(
                  name: nameController.text,
                  age: int.parse(ageController.text),
                  birthday: dateController.text);
              },
              child: const Text('Create User'),
          )
        ],
      ),
    );
  }

  Future<dynamic> createUser({required String name, required int age, required String birthday}) async{
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final waterDonate = WaterDonation(
        id: docUser.id,
        name: name,
        age: age,
        birthday: birthday
    );

    final json = waterDonate.toJson();

    await docUser.set(json);
  }
}


import 'package:clear_water_and_sanitization/DonationHandling/simple_crud/DonationList.dart';
import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UpdateUser extends StatefulWidget {

  final String userId;

  const UpdateUser(this.userId, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<UpdateUser> createState() => _UpdateUserState(userId);
}

class _UpdateUserState extends State<UpdateUser> {

  String userId;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  _UpdateUserState(this.userId);

  late WaterDonation crudUser;
  late DocumentReference<Map<String, dynamic>> singleUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Update User"),
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
              updateUser(
                name: nameController.text,
                age: int.parse(ageController.text),
                birthday: dateController.text);
            },
            child: const Text('Update User'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => alertBox(),
              );
            },
            child: const Text('Delete User'),
          ),
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
    singleUser = FirebaseFirestore.instance.collection('users').doc(userId);

    final DocumentSnapshot<Map<String, dynamic>> snapshot;

    try{
      snapshot  = await singleUser.get();

      if(snapshot.exists){
        crudUser = WaterDonation.fromJson(snapshot.data()!);
        nameController.text = crudUser.name;
        ageController.text = crudUser.age.toString();
        dateController.text = crudUser.birthday;
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

  Future<dynamic> updateUser({required String name, required int age, required String birthday}) async{

    final updatedUser = WaterDonation(
        id: singleUser.id,
        name: name,
        age: age,
        birthday: birthday
    );

    final json = updatedUser.toJson();

    try{
      await singleUser.update(json);
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  Future<dynamic> deleteUser() async{

    try{
      await singleUser.delete();
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }
}


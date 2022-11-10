import 'package:clear_water_and_sanitization/models/Awareness.dart';
import 'package:clear_water_and_sanitization/screens/Awareness/AwarenessList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UpdateAwareness extends StatefulWidget {

  final String awarenessId;

  const UpdateAwareness(this.awarenessId, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<UpdateAwareness> createState() => _UpdateUserState(awarenessId);
}

class _UpdateUserState extends State<UpdateAwareness> {

  String awarenessId;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final typeController = TextEditingController();
  final venueController = TextEditingController();

  _UpdateUserState(this.awarenessId);

  late AwarenessModel awarenessData;
  late DocumentReference<Map<String, dynamic>> singleAwareness;
  final double textBorder = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Update This Session"),
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
          Center(child: Text("Update This Session")),
          const SizedBox(height: 40),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Session Topic / Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Description About this Session',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: dateController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Date',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: timeController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Time',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: typeController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Meeting Type',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: venueController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Meeting Link / Venue',
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
              Navigator.pop(context);
              updateAwareness(
                  name: nameController.text,
                description: descriptionController.text,
                  date: dateController.text,
                  time: timeController.text,
                  type: typeController.text,
                venue: venueController.text
              );
            },
            child: const Text('Update Session', style: TextStyle(fontSize: 18)),
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
      title: const Text("Are you sure you want to delete this Session?"),
      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("No")
        ),
        ElevatedButton(
            onPressed: (){
              deleteAwareness();
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const AwarenessList();
              }));
            },
            child: const Text("Yes")
        )
      ],
    );
  }

  @override
  void initState() {
    readAwareness();
    super.initState();
  }

  readAwareness() async{
    singleAwareness = FirebaseFirestore.instance.collection('awareness').doc(awarenessId);

    print(awarenessId);

    final DocumentSnapshot<Map<String, dynamic>> snapshot;

    try{
      snapshot  = await singleAwareness.get();

      if(snapshot.exists){
        awarenessData = AwarenessModel.fromJson(snapshot.data()!);
        nameController.text = awarenessData.name;
        descriptionController.text = awarenessData.description;
        dateController.text = awarenessData.date;
        timeController.text = awarenessData.time;
        typeController.text = awarenessData.type;
        venueController.text = awarenessData.venue;
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

  Future<dynamic> updateAwareness({
    required String name,
    required String description,
    required String date,
    required String time,
    required String type,
    required String venue,
  }) async{
    final updateAwareness = AwarenessModel(
        id: singleAwareness.id,
        name: name,
      description: description,
        date: date,
        time: time,
        type: type,
      venue: venue
    );

    final json = updateAwareness.toJson();

    try{
      await singleAwareness.update(json);
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  Future<dynamic> deleteAwareness() async{
    try{
      await singleAwareness.delete();
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }
}


import 'package:clear_water_and_sanitization/models/SurveyFModel.dart';
import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/AddDonation.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/UpdateDonation.dart';
import 'package:clear_water_and_sanitization/screens/serveyManagement/AddSurvey.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyList extends StatefulWidget {
  const SurveyList({Key? key}) : super(key: key);

  @override
  State<SurveyList> createState() => _UserListState();
}

class _UserListState extends State<SurveyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Survey List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const AddSurvey();
                }));
              },
              icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<SurveyFModel>>(
        // stream: readSurvey(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final users = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              children: users.map(buildUser).toList(),
            );
          }else if(snapshot.hasError){
            if (kDebugMode) {
              print('Error --> ${snapshot.error}');
            }
            return const Center(
              child: Text("Oops Something Went Wrong..."),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(SurveyFModel Survey) {

    var borderRadius = const BorderRadius.all(Radius.circular(18));
    const double ft = 19;

    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          selectedTileColor: Colors.grey,
          selected: true,
          title: Column(
            children: [
              Row(
                children: [
                  const SizedBox(height: 7),
                  Text(
                      Survey.province,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                  const Spacer(),
                  Text(
                      Survey.district,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),

              const SizedBox(height: 7),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return UpdateDonation(Survey.id);
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        backgroundColor: Colors.green
                      ),
                      child: const Text("Update")
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) => alertBox(Survey.id),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        backgroundColor: Colors.green
                      ),
                      child: const Text("Delete")
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return UpdateDonation(Survey.id);
            }));
          },
        )
      ],
    );
  }

  alertBox<Widget>(String id) {
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
              deleteUser(id);
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const SurveyList();
              }));
            },
            child: const Text("Yes")
        )
      ],
    );
  }

  Future<dynamic> deleteUser(Id) async{
    var singleDonation = FirebaseFirestore.instance.collection('docSurvey').doc(Id);
    try{
      await singleDonation.delete();
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  Stream<List<WaterDonation>> readSurvey() => FirebaseFirestore.instance
      .collection('docSurvey')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) =>
              WaterDonation.fromJson(doc.data()),
          ).toList(),
      );
}

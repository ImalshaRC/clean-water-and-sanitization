import 'package:clear_water_and_sanitization/models/ArticleModel.dart';
import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/DonationList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UpdateArticle extends StatefulWidget {

  final String articleId;

  const UpdateArticle(this.articleId, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<UpdateArticle> createState() => _UpdateUserState(articleId);
}

class _UpdateUserState extends State<UpdateArticle> {

  String articleId;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final literController = TextEditingController();
  final phiController = TextEditingController();

  _UpdateUserState(this.articleId);

  late ArticleModel articleData;
  late DocumentReference<Map<String, dynamic>> singleArticle;
  final double textBorder = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Update Article"),
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
          Center(child: Text("Update This Article")),
          const SizedBox(height: 40),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Article Heading',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Article Description',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: mobileController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Published Date',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: literController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Published Time',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: phiController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Author Name',
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
              updateArticle(
                  name: nameController.text,
                  address: addressController.text,
                  mobile: mobileController.text,
                  liter: literController.text,
                  phi: phiController.text,
              );
            },
            child: const Text('Update Article', style: TextStyle(fontSize: 18)),
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
              deleteArticle();
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
    readArticle();
    super.initState();
  }

  readArticle() async{
    singleArticle = FirebaseFirestore.instance.collection('article').doc(articleId);

    print(articleId);

    final DocumentSnapshot<Map<String, dynamic>> snapshot;

    try{
      snapshot  = await singleArticle.get();

      if(snapshot.exists){
        articleData = ArticleModel.fromJson(snapshot.data()!);
        nameController.text = articleData.name;
        addressController.text = articleData.address;
        mobileController.text = articleData.mobile;
        literController.text = articleData.liter;
        phiController.text = articleData.phi;
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

  Future<dynamic> updateArticle({
    required String name,
    required String address,
    required String mobile,
    required String liter,
    required String phi,
  }) async{
    final updatedArticle = ArticleModel(
        id: singleArticle.id,
        name: name,
        address: address,
        mobile: mobile,
        liter: liter,
        phi: phi,
    );

    final json = updatedArticle.toJson();

    try{
      await singleArticle.update(json);
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  Future<dynamic> deleteArticle() async{
    try{
      await singleArticle.delete();
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }
}


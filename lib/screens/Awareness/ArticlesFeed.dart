
import 'package:clear_water_and_sanitization/models/ArticleFModel.dart';
import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:clear_water_and_sanitization/screens/Awareness/ArticlesFeedback.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/AddDonation.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/DonationFeedback.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/MainPage.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/UpdateDonation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticlesFeed extends StatefulWidget {
  const ArticlesFeed({Key? key}) : super(key: key);

  @override
  State<ArticlesFeed> createState() => _UserListState();
}

class _UserListState extends State<ArticlesFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Feedback List"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const ArticlesFeedback();
              }));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<ArticleFModel>>(
        stream: readFeedbacks(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final feedback = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              children: feedback.map(buildUser).toList(),
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

  Widget buildUser(ArticleFModel feedback) {

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
                      feedback.date,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                  const Spacer(),
                  Text(
                      feedback.name,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 23),
              Row(
                children: [
                  Text(
                      feedback.feedback,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 7),
            ],
          ),
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            //   return UpdateDonation(feedback.id);
            // }));
          },
        )
      ],
    );
  }

  Stream<List<ArticleFModel>> readFeedbacks() => FirebaseFirestore.instance
      .collection('articleFeedback')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) =>
          ArticleFModel.fromJson(doc.data()),
      ).toList(),
  );
}

import 'package:clear_water_and_sanitization/models/ArticleFModel.dart';
import 'package:clear_water_and_sanitization/models/DonationFModel.dart';
import 'package:clear_water_and_sanitization/screens/Awareness/ArticlesFeed.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/FeedbackList.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/MainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ArticlesFeedback extends StatefulWidget {
  const ArticlesFeedback({Key? key}) : super(key: key);

  @override
  State<ArticlesFeedback> createState() => _DonationFeedbackState();
}

class _DonationFeedbackState extends State<ArticlesFeedback> {

  final TextEditingController feedbackController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Feedback'),
      ),
      body: ListView(
        children:  [
          const Image(
            height: 40,
            image: AssetImage(
                'assets/rateus.png'
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              const Text('Rate Our App', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
              const SizedBox(height: 15),
              const Text('sscdcdccssdcs\nscddcsdcscdscsd\nsdcsdcsdcsdcs\nssdcsdcsdcsdc', style: TextStyle(fontSize: 15),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Birth Date',
                        labelText: 'Enter Number of Liters(L)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: feedbackController,
                      maxLines: 3, //or null
                      decoration: const InputDecoration.collapsed(hintText: "Enter your text here"),
                    ),
                    TextField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        hintText: 'Birth Date',
                        labelText: 'Enter Number of Liters(L)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
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
                  createDFeedback();
                },
                child: const Text('Add Feedback', style: TextStyle(fontSize: 18)),
              )
            ],
          )
        ],
      ),
    );
  }

  goToPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const ArticlesFeed();
    }));
  }

  Future<dynamic> createDFeedback() async{
    final docFeedback = FirebaseFirestore.instance.collection('articleFeedback').doc();

    final donateFeedback = ArticleFModel(
        id: docFeedback.id,
        feedback: feedbackController.text,
        date: '2022/11/10',
        name: nameController.text,
    );

    showMessage('Feedback successfully saved');

    final json = donateFeedback.toJson();

    await docFeedback.set(json);

    goToPage();
  }

  showMessage(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }


}






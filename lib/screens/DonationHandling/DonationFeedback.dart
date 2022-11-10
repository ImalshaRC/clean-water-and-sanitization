import 'package:clear_water_and_sanitization/models/DonationFModel.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/FeedbackList.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/MainPage.dart';
import 'package:clear_water_and_sanitization/screens/Home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DonationFeedback extends StatefulWidget {
  const DonationFeedback({Key? key}) : super(key: key);

  @override
  State<DonationFeedback> createState() => _DonationFeedbackState();
}

class _DonationFeedbackState extends State<DonationFeedback> {

  final TextEditingController feedbackController = TextEditingController();
  late double rateVal = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Donation Feedback'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const Home();
              }));
            },
            icon: const Icon(Icons.home),
          )
        ],
      ),
      body: ListView(
        children:  [
          const Image(
            image: AssetImage(
                'assets/rateus.png'
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Center(
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      rateVal = rating;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text('Rate Our App', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
              const SizedBox(height: 15),
              Card(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: TextField(
                      controller: feedbackController,
                      maxLines: 8, //or null
                      decoration: const InputDecoration.collapsed(hintText: "Enter your text here"),
                    ),
                  )
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan,
                  onPrimary: Colors.white,
                  shadowColor: Colors.blueAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  minimumSize: const Size(50, 50),
                ),
                onPressed: () {
                  createDFeedback(rateVal);
                },
                child: const Text('Add Feedback', style: TextStyle(fontSize: 18)),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<dynamic> createDFeedback(double rating) async{
    final docFeedback = FirebaseFirestore.instance.collection('donationFeedback').doc();

    final donateFeedback = DonationFModel(
        id: docFeedback.id,
        rate: rating,
        feedback: feedbackController.text,
        date: '2022/11/10',
    );

    showMessage('Feedback successfully saved');

    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const FeedbackList();
    }));

    final json = donateFeedback.toJson();

    await docFeedback.set(json);
  }

  showMessage(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

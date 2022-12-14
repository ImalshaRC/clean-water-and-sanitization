import 'package:clear_water_and_sanitization/screens/DonationHandling/AddDonation.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/DonationList.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/FeedbackList.dart';
import 'package:clear_water_and_sanitization/screens/Home/home.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Donation Main Page'),
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 20),
          const Image(
              image: AssetImage('assets/donation1.png'),
              // width: ,
          ),
          const SizedBox(height: 80),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                shadowColor: Colors.blueGrey,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                minimumSize: const Size(100, 60),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const AddDonation()));
              },
              child: const Text('Add Donation', style: TextStyle(fontSize: 24))
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                shadowColor: Colors.blueGrey,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                 ),
                minimumSize: const Size(100, 60),
              ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> const DonationList()));
            },
            child: const Text('View All Donations', style: TextStyle(fontSize: 24))
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                shadowColor: Colors.blueGrey,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                ),
                minimumSize: const Size(100, 60),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const FeedbackList()));
              },
              child: const Text('Feedbacks', style: TextStyle(fontSize: 24))
          )
        ],
      ),
    );
  }
}

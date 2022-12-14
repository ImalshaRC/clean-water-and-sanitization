import 'package:clear_water_and_sanitization/screens/Articles/AddArticles.dart';
import 'package:clear_water_and_sanitization/screens/Articles/ArticlesFeedback.dart';
import 'package:clear_water_and_sanitization/screens/Articles/ArticlesList.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/AddDonation.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/DonationChart.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/DonationList.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/FeedbackList.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/MainPage.dart';
import 'package:clear_water_and_sanitization/screens/Home/BuyAProduct/categories.dart';
import 'package:clear_water_and_sanitization/screens/Home/BuyAProduct/orderlist.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../authentication/email_sign_in.dart';

final AuthService _auth = AuthService();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class _HomeState extends State<Home> {

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      child:  Row(
        children: [
          Text(title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0.0,
          title: const Text('Home'),
          actions: [
            PopupMenuButton(
              itemBuilder: (ctx) => [
                _buildPopupMenuItem('Search'),
                _buildPopupMenuItem('Upload'),
                _buildPopupMenuItem('Copy'),
                _buildPopupMenuItem('Exit'),
              ],
            )
          ],

        ),
        drawer: Drawer(
      child: ListView(
          padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
          children:  [
            // DrawerHeader(
            //     decoration: const BoxDecoration(
            //       color: Colors.cyan,
            //     ),
            //     child: Center(child: Wrap(
            //       children: <Widget>[
            //         Column(
            //           children:  const [
            //             Text('Full Name',style: TextStyle(color: Colors.white)),
            //             Text('Email',style: TextStyle(color: Colors.white))
            //           ],
            //         )
            //       ],
            //     ))
            // ),
            ListTile(
              title:  const Text('Profile'),
              onTap: (){
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (_)=> const Profile()));
              },
            ),
            ListTile(
              title:  const Text('Donation Main Menu'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const MainPage()));
                // Navigator.push(context, MaterialPageRoute(builder: (_)=> const Profile()));
              },
            ),
            ListTile(
              title:  const Text('Add Donation'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const AddDonation()));
                // Navigator.push(context, MaterialPageRoute(builder: (_)=> const Profile()));
              },
            ),
            ListTile(
              title:  const Text('All Donations'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const DonationList()));
                // Navigator.push(context, MaterialPageRoute(builder: (_)=> const Profile()));
              },
            ),
            ListTile(
              title:  const Text('Donation Feedback'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const FeedbackList()));
                // Navigator.push(context, MaterialPageRoute(builder: (_)=> const Profile()));
              },
            ),
            ListTile(
              title:  const Text('Donation Pie Chart'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const DonationChart()));
                // Navigator.push(context, MaterialPageRoute(builder: (_)=> const Profile()));
              },
            ),
            ListTile(
              title:  const Text('Buy A Product'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const Categories()));
              },
            ),
            ListTile(
              title:  const Text('Orders'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const OrderList()));
              },
            ),
            ListTile(
              title:  const Text('Exit'),
              onTap: (){
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title:  const Text('Logout'),
              onTap: () async {
                dynamic result = await _auth.signOut();
                print(result);
                Navigator.pop(context);
                if(result=='Success'){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Successfully Signed Out'),
                      ));
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const EmailSignin()));
                }

              },
            ),

          ]
      ),
    ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Column(
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        dynamic result = await _auth.signOut();
                        print(result);
                        if(result=='Success'){
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Successfully Signed Out'),
                              ));
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> const EmailSignin()));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              new SnackBar(content: new Text(result),
                              ));
                        }


                      },
                      child: const Text('Sign Out'),
                    ),
                  )
                ],
              )
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const MainPage()));
                },
                child: const Text('Donation handling'),
            ),

            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const AddArticle()));
              },
              child: const Text('articles'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const ArticleList()));
              },
              child: const Text('articles list'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const ArticlesFeedback()));
              },
              child: const Text('articles feedback'),
            )
          ],
        )
    );
  }
}


import 'package:clear_water_and_sanitization/screens/Home/BuyAProduct/handsanitizers.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0.0,
          title: const Text('Categories'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const Home();
                }));
              },
              icon: const Icon(Icons.home),
            ),
          ],
        ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0,30.0,0.0,00.0),
            child:Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> HandSanitizer()));
                      },
                      child: const Text('Hand Sanitizers'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 100),
                          primary: Colors.cyan,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> HandSanitizer()));
                      },
                      child: const Text('Hand Wash'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 100),
                          primary: Colors.cyan,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> HandSanitizer()));
                      },
                      child: const Text('Shampoo'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 100),
                          primary: Colors.cyan,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> HandSanitizer()));
                      },
                      child: const Text('Brush'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 100),
                          primary: Colors.cyan,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> HandSanitizer()));
                      },
                      child: const Text('ToothPaste'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 100),
                          primary: Colors.cyan,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> HandSanitizer()));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 100),
                          primary: Colors.cyan,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      child: const Text('Deodrants'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> HandSanitizer()));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 100),
                          primary: Colors.cyan,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      child: const Text('Perfume'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> HandSanitizer()));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 100),
                          primary: Colors.cyan,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      child: const Text('Soap'),
                    ),
                  ),
                ],
              ),
            ),
          )
      )
    );
  }
}

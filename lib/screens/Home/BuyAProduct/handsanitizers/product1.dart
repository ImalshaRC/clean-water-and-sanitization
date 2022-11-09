import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/SingleUser.dart';
import '../checkout.dart';


class ProductOne extends StatefulWidget {
  const ProductOne({Key? key}) : super(key: key);

  @override
  State<ProductOne> createState() => _ProductOneState();



}

class _ProductOneState extends State<ProductOne> {

  late SingleUser singleUser;
  late DocumentReference<Map<String, dynamic>> oneUser;

  void getUserById(userId) async{

    oneUser = FirebaseFirestore.instance.collection('userData').doc(userId);

    final DocumentSnapshot<Map<String, dynamic>> snapshot;
    snapshot = await oneUser.get();

    if(snapshot.exists){
      singleUser = SingleUser.fromJson(snapshot.data()!);
      changeScreen(singleUser);
    }else{
      if (kDebugMode) {
        print("No data found");
      }
    }
  }

  void changeScreen(singleUser) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return Checkout(singleUser);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController qty = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0.0,
          title: const Text('Komarika Hand Sanitizer'),
        ),
        body:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 250,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/hs.webp',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const Padding(padding:EdgeInsets.fromLTRB(0.0,20.0,0.0,00.0),
                    child: Text('Komarika Hand Sanitizer',
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),),
              Container(
                child: Column(
                  children: const <Widget> [
                    Padding(padding:EdgeInsets.fromLTRB(10.0,30.0,0.0,00.0),
                      child: Text('Genuine 3M brand hand sanitiser with 70% alcohol content.',
                        style: TextStyle(fontSize: 20,),
                      ),
                    ),
                    Padding(padding:EdgeInsets.fromLTRB(10.0,10.0,0.0,00.0),
                      child: Text('Non sticky, dry fast and safe to use.Skin issues: regular hand cleansing.',
                        style: TextStyle(fontSize: 20,),
                      ),
                    ),
                    Padding(padding:EdgeInsets.fromLTRB(10.0,10.0,0.0,00.0),
                      child: Text('Time of application: as often as necessary. Skin type: all skin types, including sensitive.',
                        style: TextStyle(fontSize: 20,),
                      ),
                    ),
                    Padding(padding:EdgeInsets.fromLTRB(10.0,10.0,0.0,00.0),
                      child: Text('Age: 3+ (children must use under adult supervision).',
                        style: TextStyle(fontSize: 20,),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding:EdgeInsets.fromLTRB(20.0,0.0,0.0,20.0),
                child: TextFormField(
                  controller: qty,
                  decoration: const InputDecoration(
                    hintText: 'Amount you need to buy',
                    labelText: 'Quantity *',

                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 00.0, 0.0, 0.0),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> Checkout(singleUser)));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.cyan
                  ),
                  child: const Text('Add To Cart',
                    style: TextStyle(fontSize: 20),),
                ),),

            ],
          ),
        )


    );
  }
}

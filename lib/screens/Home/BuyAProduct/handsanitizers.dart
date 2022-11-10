import 'package:clear_water_and_sanitization/screens/Home/BuyAProduct/categories.dart';
import 'package:clear_water_and_sanitization/screens/Home/BuyAProduct/handsanitizers/Product2.dart';
import 'package:clear_water_and_sanitization/screens/Home/BuyAProduct/handsanitizers/product1.dart';
import 'package:clear_water_and_sanitization/screens/Home/BuyAProduct/handsanitizers/product3.dart';
import 'package:clear_water_and_sanitization/screens/Home/BuyAProduct/handsanitizers/product4.dart';
import 'package:flutter/material.dart';


class HandSanitizer extends StatelessWidget {
  const HandSanitizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0.0,
          title: const Text('Hand Sanitizers'),
        ),
        body: ListView(
          children:  <Widget>[
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const ProductOne()));
                },
                leading: Image.asset('assets/hs.webp'),
                title: const Text('Komarika Hand Sanitizer'),
                subtitle: const Text(
                    "Rs.585.00"
                ),
                // trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const ProductTwo()));
                },
                leading: Image.asset('assets/hs1.webp'),
                title: const Text('Safeguard Hand Sanitizer'),
                subtitle: const Text(
                    "Rs.132.00"
                ),
                // trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const ProductThree()));
                },
                leading: Image.asset('assets/hs2.webp'),
                title: const Text('Safeguard Sanitizng Gel'),
                subtitle: const Text(
                    "Rs.236.00"
                ),
                // trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const ProductFour()));
                },
                leading: Image.asset('assets/hs3.webp'),
                title: const Text('Safeguard Citrus Sanitizer'),
                subtitle: const Text(
                    "Rs.340.00"
                ),
                // trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),

          ],
        )
    );
  }
}

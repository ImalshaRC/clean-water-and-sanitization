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



  Color color1 = HexColor("b74093");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0.0,
          title: const Text('Home'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Center(
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
            )
          ],
        )
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Home/home.dart';
import 'authentication/email_sign_in.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    print(user);
    if(user!=null){
      return const Home();
    }
    else{
      return const EmailSignin();
    }
  }

}

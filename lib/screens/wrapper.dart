import 'package:flutter/material.dart';
import 'authentication/email_sign_in.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //return either Home or Authenticate widget
    return const EmailSignin();
    // return FormScreen();
  }

}

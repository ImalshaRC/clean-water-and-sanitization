import 'package:clear_water_and_sanitization/screens/authentication/email_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Authenticate extends StatefulWidget {

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: EmailSignin()
    );
  }
}

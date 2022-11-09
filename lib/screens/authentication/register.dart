import 'package:clear_water_and_sanitization/services/validators.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';
import 'email_sign_in.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent[050],
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0.0,
          title: const Text('Register'),
        ),
        body: const SingleChildScrollView(
            child: RegisterFormWidget()
        )
    );
  }
}

//Create Form Widget
class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({Key? key}) : super(key: key);

  @override
  State<RegisterFormWidget> createState() {
    return RegistrationFromState();
  }
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RegistrationFromState extends State<RegisterFormWidget>{

  final AuthService _auth = AuthService();

  final _registrationFormKey = GlobalKey<FormState>();

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _adress = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _registrationFormKey,

        autovalidateMode: AutovalidateMode.always,
        onChanged: () {
          Form.of(primaryFocus!.context!)!.save();
        },
        child: Wrap(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
              child: Center(child: Text('Register',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.black54,
                ),
              ),
              ),),
            const Padding(
              padding: EdgeInsets.fromLTRB(20.0,10.0,20.0,30.0),
              child: Center(child: Text('Fill the following fields to sign up',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black54,
                ),
              ),
              ),),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  TextFormField(
                    controller: _firstName,
                    decoration: const InputDecoration(
                      hintText: 'What is your first name?',
                      labelText: 'First Name *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter Your First Name';
                      }
                      if(!value.isValidName()){
                        return 'Name should not contain any numbers';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _lastName,
                    decoration: const InputDecoration(
                      hintText: 'What is your last name?',
                      labelText: 'Last Name *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter Your Last Name';
                      }
                      if(!value.isValidName()){
                        return 'Name should not contain any numbers';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _age,
                    decoration: const InputDecoration(
                      hintText: 'How old are you?',
                      labelText: 'Age *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter a number';
                      }
                      if(!value.isValidNumber()){
                        return 'Age should be a number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneNo,
                    decoration: const InputDecoration(
                      hintText: 'What is your phone number?',
                      labelText: 'Phone Number *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter a number';
                      }
                      if(!value.isValidNumber()){
                        return 'Phone Number should be a number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _adress,
                    decoration: const InputDecoration(
                      hintText: 'What is your address',
                      labelText: 'Address *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter Your Address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      hintText: 'What is your email',
                      labelText: 'Email *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter an email';
                      }
                      if(!value.isValidEmail()){
                        return 'Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _pass,
                    obscureText: true,
                    decoration: const InputDecoration(

                      hintText: 'Enter a Strong Password',
                      labelText: 'Password *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter a password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _confirmPass,
                    obscureText: true,
                    decoration: const InputDecoration(

                      hintText: 'Enter a Strong Password',
                      labelText: 'Confirm Password *',

                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter a password';
                      }
                      if(_pass.text!=_confirmPass.text){
                        return 'Password do not match';
                      }
                      return null;
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_registrationFormKey.currentState!.validate()) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(content: Text('Processing Data')),
                              //
                              // );
                              dynamic result = await _auth.register(_firstName.text,_lastName.text,_age.text,_phoneNo.text,_adress.text,_email.text, _pass.text);
                              print(result);
                              if(result=='Success'){
                                print('Successfully Created Account');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Successfully Created Account'),
                                    ));
                                Navigator.push(context, MaterialPageRoute(builder: (_)=> const EmailSignin()));
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: new Text(result),
                                    ));
                              }



                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.cyan
                        ),
                          child: const Text('   Register   ',
                            style: TextStyle(fontSize: 22),),
                        ),),
                    ],
                  )
                ],
              ),
            )
          ],

        )
    );
  }

}


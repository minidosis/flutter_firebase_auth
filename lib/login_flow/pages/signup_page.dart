import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/auth_page_title.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/button_sign_in.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/text_field.dart';

class EmailAndPassword {
  final String email, password;
  EmailAndPassword(this.email, this.password);

  toString() => "Email: '$email' / Password: '$password'";
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 100),
              AuthPageTitle('Sign Up'),
              SizedBox(height: 24),
              SignInTextField(SignInTextFieldType.email, _email),
              SizedBox(height: 24),
              SignInTextField(SignInTextFieldType.password, _password),
              SizedBox(height: 48),
              SignInButton(
                text: 'Sign Up',
                onPressed: () {
                  Navigator.of(context).pop(
                    EmailAndPassword(_email.text, _password.text),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

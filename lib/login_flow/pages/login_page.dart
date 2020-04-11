import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/button_sign_in.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/button_sign_in_with.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/text_field.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/or_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loggingIn = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _signInAnonymously() async {
    setState(() {
      _loggingIn = true;
    });
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _loggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loggingIn) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 120),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 40,
                      color: primaryColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                SignInTextField(
                  'Username',
                  controller: _usernameController,
                ),
                SizedBox(height: 16),
                SignInTextField(
                  'Password',
                  showEyeIcon: true,
                  controller: _passwordController,
                ),
                SizedBox(height: 48),
                SignInButton(
                    color: primaryColor,
                    onPressed: () {
                      print(_usernameController.text);
                      print(_passwordController.text);
                    }),
                OrBar(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SignInWithButton(
                        'Google',
                        FontAwesomeIcons.google,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: SignInWithButton(
                        'Facebook',
                        FontAwesomeIcons.facebook,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                FlatButton(
                  child: Text(
                    'Sign in anonymously',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  onPressed: _signInAnonymously,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

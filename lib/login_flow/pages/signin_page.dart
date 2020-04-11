import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/login_flow/auth_state_switch.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/button_sign_in.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/button_sign_in_with.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/text_field.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/or_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _signingIn = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  _showSnackbar(String message, [Color backgroundColor = Colors.black87]) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  _signIn(Function signInFunc) async {
    setState(() => _signingIn = true);
    try {
      await signInFunc();
    } catch (e) {
      _showSnackbar(e.toString(), Colors.red);
      setState(() => _signingIn = false);
    }
  }

  _anonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  _withEmailAndPassword() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _email.text,
      password: _password.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_signingIn) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final SignInConfig config = Provider.of<SignInConfig>(context);
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
                SignInTextField('Email', isEmail: true, controller: _email),
                SizedBox(height: 16),
                SignInTextField('Password',
                    showEyeIcon: true, controller: _password),
                SizedBox(height: 48),
                SignInButton(
                  color: primaryColor,
                  onPressed: () => _signIn(_withEmailAndPassword),
                ),
                OrBar(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SignInWithButton(
                        'Google',
                        FontAwesomeIcons.google,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: SignInWithButton(
                        'Facebook',
                        FontAwesomeIcons.facebook,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                if (config.canLoginAnonymously)
                  FlatButton(
                    child: Text(
                      'Sign in anonymously',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    onPressed: () => _signIn(_anonymously),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

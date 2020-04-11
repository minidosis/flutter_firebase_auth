import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/login_flow/auth_state_switch.dart';
import 'package:flutter_firebase_auth/login_flow/pages/signup_page.dart';
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
  bool _showProgress = false;
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

  _waitAndCheckErrors(Function signInFunc) async {
    setState(() => _showProgress = true);
    try {
      await signInFunc();
    } catch (e) {
      _showSnackbar(e.toString(), Colors.red);
      setState(() => _showProgress = false);
    }
  }

  _signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  _signInWithEmailAndPassword() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _email.text,
      password: _password.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showProgress) {
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
                ,
                SizedBox(height: 24),
                SignInTextField(SignInTextFieldType.email, _email),
                SizedBox(height: 16),
                SignInTextField(SignInTextFieldType.password, _password),
                SizedBox(height: 32),
                SignInButton(
                  color: primaryColor,
                  onPressed: () =>
                      _waitAndCheckErrors(_signInWithEmailAndPassword),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Need an account?',
                      style: TextStyle(
                        color: Colors.black45,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(width: 16),
                    FlatButton(
                      child: Text('Register'),
                      textColor: primaryColor,
                      onPressed: () async {
                        EmailAndPassword result =
                            await Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SignUpPage()),
                        );
                        print(result);
                      },
                    ),
                  ],
                ),
                OrBar(spaceTop: 12, spaceBottom: 24),
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
                    onPressed: () => _waitAndCheckErrors(_signInAnonymously),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth/login_flow/auth_state_switch.dart';
import 'package:flutter_firebase_auth/login_flow/pages/signup_page.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/auth_page_title.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/button_sign_in.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/button_sign_in_with.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/or_bar.dart';
import 'package:flutter_firebase_auth/login_flow/widgets/text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _SignInPageBody(),
      backgroundColor: Colors.white,
    );
  }
}

class _SignInPageBody extends StatefulWidget {
  @override
  _SignInPageBodyState createState() => _SignInPageBodyState();
}

class _SignInPageBodyState extends State<_SignInPageBody> {
  bool _showProgress = false;
  TextEditingController _ctrlEmail, _ctrlPassword;
  bool signButtonActive = false;

  @override
  void initState() {
    super.initState();
    _ctrlEmail = TextEditingController();
    _ctrlPassword = TextEditingController();
    _ctrlEmail.addListener(_updateSignButtonActive);
    _ctrlPassword.addListener(_updateSignButtonActive);
  }

  _updateSignButtonActive() {
    setState(() {
      signButtonActive =
          (_ctrlEmail.text.isNotEmpty && _ctrlPassword.text.isNotEmpty);
    });
  }

  _showSnackbar(String message, {IconData icon, Color color = Colors.red}) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            if (icon != null) ...[Icon(icon), SizedBox(width: 10)],
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
      ),
    );
  }

  _showError(PlatformException e) {
    switch (e.code) {
      case 'ERROR_TOO_MANY_REQUESTS':
        _showSnackbar(
          "Too many unsuccessful login attempts, try again later.",
          icon: Icons.warning,
        );
        break;
      case 'ERROR_WRONG_PASSWORD':
      case 'ERROR_USER_NOT_FOUND':
        _showSnackbar("Wrong user and password combination");
        break;
      case 'ERROR_INVALID_EMAIL':
        _showSnackbar("Invalid email");
        break;
      default:
        return "Unknown error '${e.code}'";
    }
  }

  _waitAndCheckErrors(Function signInFunc) async {
    setState(() => _showProgress = true);
    try {
      await signInFunc();
    } on PlatformException catch (e) {
      _showError(e);
      setState(() => _showProgress = false);
    }
  }

  _signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  _signInWithEmailAndPassword() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _ctrlEmail.text,
      password: _ctrlPassword.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showProgress) {
      return Center(child: CircularProgressIndicator());
    }
    final SignInConfig config = Provider.of<SignInConfig>(context);
    final primaryColor = Theme.of(context).primaryColor;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 120),
              AuthPageTitle('Sign In'),
              SizedBox(height: 24),
              SignInTextField(SignInTextFieldType.email, _ctrlEmail),
              SizedBox(height: 16),
              SignInTextField(SignInTextFieldType.password, _ctrlPassword),
              SizedBox(height: 32),
              SignInButton(
                color: primaryColor,
                onPressed: signButtonActive
                    ? () => _waitAndCheckErrors(_signInWithEmailAndPassword)
                    : null,
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
    );
  }
}

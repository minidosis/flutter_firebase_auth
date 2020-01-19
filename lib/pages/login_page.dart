import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/widgets/or_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loggingIn = false;
  bool _viewPassword = false;

  _textField(TextEditingController controller, String what, {showIcon: false}) {
    Widget eye;
    if (showIcon) {
      eye = IconButton(
        icon: Icon(_viewPassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            _viewPassword = !_viewPassword;
          });
        },
      );
    }
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        hintText: what,
        hintStyle: TextStyle(color: Colors.grey[400]),
        suffixIcon: eye,
      ),
      obscureText: showIcon && !_viewPassword,
    );
  }

  _signInLabel(Color c) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Sign In',
          style: TextStyle(
            fontSize: 40,
            color: c,
            fontWeight: FontWeight.w300,
          ),
        ),
      );

  _signInAnonymously() => FlatButton(
        child: Text('Sign in anonymously', style: TextStyle(color: Colors.grey[500])),
        onPressed: () async {
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
        },
      );

  _signInButton(Color color) => FlatButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text('Sign In',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        color: color,
        padding: EdgeInsets.all(16),
      );

  _signInWithButton(String whom, IconData iconData) {
    final grey = Colors.grey[600];
    return OutlineButton(
      onPressed: () {},
      padding: EdgeInsets.fromLTRB(16, 14, 20, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, size: 24, color: grey),
          SizedBox(width: 20),
          Text('Sign in\nwith $whom',
              style: TextStyle(fontSize: 11, color: grey)),
        ],
      ),
    );
  }

  _body(context) {
    if (_loggingIn) {
      return Center(child: CircularProgressIndicator());
    }
    final primaryColor = Theme.of(context).primaryColor;
    return Center(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 120),
                  _signInLabel(primaryColor),
                  SizedBox(height: 24),
                  _textField(null, 'Username'),
                  SizedBox(height: 16),
                  _textField(null, 'Password', showIcon: true),
                  SizedBox(height: 48),
                  _signInButton(primaryColor),
                  OrBar(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _signInWithButton(
                            'Google', FontAwesomeIcons.google),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _signInWithButton(
                            'Facebook', FontAwesomeIcons.facebook),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          _signInAnonymously(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) => _body(context),
        ),
      ),
    );
  }
}

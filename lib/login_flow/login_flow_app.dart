import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/login_flow/pages/login_page.dart';
import 'package:flutter_firebase_auth/login_flow/pages/signup_page.dart';

class LoginFlowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => LoginPage(),
        '/signup': (_) => SignUpPage(),
      }
    );
  }
}

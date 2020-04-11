import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/login_flow/pages/signin_page.dart';

class SignInFlowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
    );
  }
}

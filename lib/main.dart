import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/pages/home_page.dart';
import 'package:flutter_firebase_auth/pages/login_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return LoginPage();
          }
          return Provider<FirebaseUser>.value(
            value: user,
            child: HomePage(),
          );
        }
        return MaterialApp(
          home: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

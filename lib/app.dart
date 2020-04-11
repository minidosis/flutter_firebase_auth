import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/pages/about_page.dart';
import 'package:flutter_firebase_auth/pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (_) => HomePage(),
        '/about': (_) => AboutPage(),
      },
    );
  }
}

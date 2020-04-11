import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/login_flow/login_flow_app.dart';
import 'package:flutter_firebase_auth/login_flow/pages/splash_page.dart';
import 'package:provider/provider.dart';

class AuthStateSwitch extends StatelessWidget {
  final Widget app;
  AuthStateSwitch({this.app});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasError) {
          return SplashPage(error: snapshot.error.toString());
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return SplashPage(error: "ConnectionState is none!");

          case ConnectionState.waiting:
            return SplashPage();

          case ConnectionState.active:
            {
              final FirebaseUser user = snapshot.data;
              return user == null
                  ? LoginFlowApp()
                  : Provider<FirebaseUser>.value(
                      value: user,
                      child: this.app,
                    );
            }

          case ConnectionState.done:
          default:
            return SplashPage(error: "ConnectionState is done!");
        }
      },
    );
  }
}
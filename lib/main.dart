import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app.dart';

import 'login_flow/auth_state_switch.dart';

void main() {
  runApp(
    AuthStateSwitch(
      app: App(),
      config: SignInConfig(
        anonymously: false,
        withGoogle: false,
        withFacebook: false,
      ),
    ),
  );
}

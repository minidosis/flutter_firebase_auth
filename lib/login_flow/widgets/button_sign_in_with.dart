
import 'package:flutter/material.dart';

class SignInWithButton extends StatelessWidget {
  final String whom;
  final IconData iconData;
  final Function onPressed;
  SignInWithButton(this.whom, this.iconData, { this.onPressed });

  @override
  Widget build(BuildContext context) {
    final grey = Colors.grey[600];
    return OutlineButton(
      onPressed: onPressed,
      padding: EdgeInsets.fromLTRB(16, 14, 20, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, size: 24, color: grey),
          SizedBox(width: 14),
          Text('Sign in\nwith $whom',
              style: TextStyle(fontSize: 11, color: grey)),
        ],
      ),
    );
  }
}

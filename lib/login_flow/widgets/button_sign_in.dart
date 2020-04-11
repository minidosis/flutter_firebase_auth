import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  SignInButton({ this.color = Colors.blue, @required this.onPressed });

  @override
  Widget build(BuildContext context) {
    return 
      FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text('Sign In',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        color: color,
        padding: EdgeInsets.all(16),
      
    );
  }
}

import 'package:flutter/material.dart';

class SignInTextField extends StatefulWidget {
  final bool showEyeIcon;
  final String what;
  final TextEditingController controller;
  SignInTextField(this.what, { this.showEyeIcon = false, @required this.controller });

  @override
  _SignInTextFieldState createState() => _SignInTextFieldState();
}

class _SignInTextFieldState extends State<SignInTextField> {
  bool _viewPassword = false;
  
  @override
  Widget build(BuildContext context) {
    Widget eye;
    if (widget.showEyeIcon) {
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
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        hintText: widget.what,
        hintStyle: TextStyle(color: Colors.grey[400]),
        suffixIcon: eye,
      ),
      obscureText: widget.showEyeIcon && !_viewPassword,
    );
  }
}

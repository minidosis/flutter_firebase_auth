import 'package:flutter/material.dart';

class OrBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final grey = Colors.grey[400];
    final line = Expanded(child: Container(height: 1, color: grey));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: <Widget>[
          line,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'or',
              style: TextStyle(
                color: grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          line,
        ],
      ),
    );
  }
}

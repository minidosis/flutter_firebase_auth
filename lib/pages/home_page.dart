import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  TableRow _row(String concept, String value) {
    const padding = const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0);
    return TableRow(children: [
      Padding(
        padding: padding,
        child: Text(
          concept,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: padding,
        child: Text(value ?? 'null'),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Esta es la página principal'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Has entrado con el siguiente usuario:"),
              SizedBox(height: 10),
              Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: {
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                },
                children: [
                  _row('uid', user.uid),
                  _row('providerId', user.providerId),
                  _row('email', user.email),
                  _row('displayName', user.displayName),
                  _row('photoUrl', user.photoUrl),
                  _row('isAnonymous', user.isAnonymous ? 'true' : 'false'),
                ],
              ),
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                  child: Text('Logout'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

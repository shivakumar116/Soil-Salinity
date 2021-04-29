import 'package:flutter/material.dart';

class ManageUsers extends StatefulWidget {
  ManageUsers({Key key}) : super(key: key);

  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("Manage Users"),
        ),
        body: Text(""),
      ),
    );
  }
}

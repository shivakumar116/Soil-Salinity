import 'package:flutter/material.dart';

class ManageSensors extends StatefulWidget {
  ManageSensors({Key key}) : super(key: key);

  @override
  _ManageSensorsState createState() => _ManageSensorsState();
}

class _ManageSensorsState extends State<ManageSensors> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("Manage Devices"),
        ),
        body: Column(),
      ),
    );
  }
}

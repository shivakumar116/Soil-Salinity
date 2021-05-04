import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageSensors extends StatefulWidget {
  ManageSensors({Key key}) : super(key: key);

  @override
  _ManageSensorsState createState() => _ManageSensorsState();
}

class _ManageSensorsState extends State<ManageSensors> {
  bool islistready = false;

  Widget getdevicedetails(String sp) {
    double right = MediaQuery.of(context).size.height * 0.1;
    return FutureBuilder(
        future:
            Firestore.instance.collection("Sensor Values").document(sp).get(),
        builder: (context, usersnapshot) {
          if (usersnapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.23,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 15, 12, 13),
                            child: Text(
                              "Device " +
                                  usersnapshot.data.documentID.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 20, 13),
                            child: Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            usersnapshot.data['temp'].toString() + "°C",
                            style: TextStyle(fontSize: 19),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.waterfall_chart,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(usersnapshot.data['moisture'].toString(),
                              style: TextStyle(fontSize: 21)),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                          child: Icon(
                            Icons.picture_as_pdf,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (usersnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            print(usersnapshot.connectionState);
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget builddevicelist() {
    return StreamBuilder(
        stream: Firestore.instance.collection("Sensor Values").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                itemBuilder: (context, index) =>
                    getdevicedetails(snapshot.data.documents[index].documentID),
                itemCount: snapshot.data.documents.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true);
          } else {
            print("hello");
            return CircularProgressIndicator();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text("Manage Devices"),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              islistready == true
                  ? CircularProgressIndicator()
                  : builddevicelist(),
            ],
          )),
    );
  }
}

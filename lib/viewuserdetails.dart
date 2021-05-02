import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewUserDetails extends StatefulWidget {
  String uid;
  ViewUserDetails(this.uid);

  @override
  _ViewUserDetailsState createState() => _ViewUserDetailsState();
}

class _ViewUserDetailsState extends State<ViewUserDetails> {
  bool isinfoloaded = false;
  String name = "";
  String email = "";
  int phonenumber;
  String device_id = ' ';

  @override
  Widget buildusertable() {
    return FutureBuilder(
        future:
            Firestore.instance.collection("users").document(widget.uid).get(),
        builder: (context, userdata) {
          if (userdata.connectionState == ConnectionState.done) {
            return Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Container(
                    child: Table(
                      border: TableBorder.all(width: 2, color: Colors.black),
                      columnWidths: {
                        0: FractionColumnWidth(.4),
                        1: FractionColumnWidth(.6)
                      },
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                              child: Text(
                                userdata.data['name'],
                                style: TextStyle(fontSize: 15),
                              )),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                              child: Text(
                                userdata.data['email'],
                                style: TextStyle(fontSize: 15),
                              )),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                            child: Text(
                              "Phone Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                              child: Text(
                                userdata.data['phonenumber'],
                                style: TextStyle(fontSize: 15),
                              )),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                            child: Text(
                              "Device Linked",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                              child: Text(
                                userdata.data['device_id'],
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              )),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("User Info"),
          centerTitle: true,
        ),
        body: buildusertable());
  }
}

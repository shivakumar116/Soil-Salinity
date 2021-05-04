import 'dart:ui';

import 'package:Soil_Salinity/viewuserdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageUsers extends StatefulWidget {
  ManageUsers({Key key}) : super(key: key);

  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  bool islistready = false;

  Widget getuserdetails(String sp) {
    double right = MediaQuery.of(context).size.height * 0.1;
    return StreamBuilder(
        stream: Firestore.instance.collection("users").document(sp).snapshots(),
        builder: (context, usersnapshot) {
          if (usersnapshot.connectionState == ConnectionState.active) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 30,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(usersnapshot.data['name'],
                                style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewUserDetails(
                                      usersnapshot.data.documentID,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.remove_red_eye_rounded),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("View"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                showAlertDialog(BuildContext context) {
                                  // set up the buttons
                                  Widget remindButton = FlatButton(
                                    child: Text("Remind me later"),
                                    onPressed: () {},
                                  );
                                  Widget cancelButton = FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {},
                                  );
                                  Widget launchButton = FlatButton(
                                    child: Text("Launch missile"),
                                    onPressed: () {},
                                  );

                                  // set up the AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Notice"),
                                    content: Text(
                                        "Launching this missile will destroy the entire universe. Is this what you intended to do?"),
                                    actions: [
                                      remindButton,
                                      cancelButton,
                                      launchButton,
                                    ],
                                  );

                                  // show the dialog
                                }

                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Confirmation"),
                                    content: Text(
                                        "Are you sure you want to delete user ?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Firestore.instance
                                              .collection("users")
                                              .document(
                                                  usersnapshot.data.documentID)
                                              .delete();
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text("Yes"),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text("No"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Delete"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
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

  Widget builduserlist() {
    return StreamBuilder(
        stream: Firestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                itemBuilder: (context, index) =>
                    getuserdetails(snapshot.data.documents[index].documentID),
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
          title: Text("Manage Users"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            islistready == true ? CircularProgressIndicator() : builduserlist(),
          ],
        ),
      ),
    );
  }
}

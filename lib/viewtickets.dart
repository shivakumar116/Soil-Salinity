import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewTickets extends StatefulWidget {
  ViewTickets({Key key}) : super(key: key);

  @override
  _ViewTicketsState createState() => _ViewTicketsState();
}

class _ViewTicketsState extends State<ViewTickets> {
  bool islistready = false;

  Widget getuserdetails(String sp) {
    double right = MediaQuery.of(context).size.height * 0.1;
    return StreamBuilder(
        stream:
            Firestore.instance.collection("Tickets").document(sp).snapshots(),
        builder: (context, usersnapshot) {
          if (usersnapshot.connectionState == ConnectionState.active) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Subject : " + usersnapshot.data['subject'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Raised by : " + usersnapshot.data['name'])
                      ],
                    ),
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
        stream: Firestore.instance.collection("Tickets").snapshots(),
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
          title: Text("Help & Support"),
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

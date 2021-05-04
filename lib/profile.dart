import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isMainLoading = true;
  String username;
  final firebase_auth = FirebaseAuth.instance;
  String email;
  String phonenumber;

  @override
  void initState() {
    super.initState();
    retriveValues();
  }

  retriveValues() async {
    setState(() {
      isMainLoading = true;
    });

    final FirebaseUser user = await firebase_auth.currentUser();
    DocumentSnapshot userdata =
        await Firestore.instance.collection("users").document(user.uid).get();
    username = userdata.data['name'];
    email = userdata.data['email'];
    phonenumber = userdata.data['phonenumber'];

    setState(() {
      isMainLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: isMainLoading == true
              ? Scaffold(body: Center(child: CircularProgressIndicator()))
              : Stack(
                  children: [
                    Container(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(83, 131, 150, 1),
                          boxShadow: [new BoxShadow(blurRadius: 0.0)],
                          borderRadius: new BorderRadius.vertical(
                              bottom: new Radius.elliptical(
                                  MediaQuery.of(context).size.width, 100.0)),
                        )),
                    Column(
                      children: [
                        SizedBox(
                          height: 160,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 32,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                                color: Color.fromRGBO(83, 131, 150, 1),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_outlined,
                                size: 30,
                                color: Color.fromRGBO(83, 131, 150, 1),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                username,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black45,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                          child: SingleChildScrollView(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  size: 30,
                                  color: Color.fromRGBO(83, 131, 150, 1),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  email,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black45,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_android,
                                size: 30,
                                color: Color.fromRGBO(83, 131, 150, 1),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                phonenumber,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black45,
                        )
                      ],
                    )
                  ],
                )),
    );
  }
}

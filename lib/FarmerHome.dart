import 'dart:ui';

import 'package:Soil_Salinity/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Leachingout.dart';
import 'package:http/http.dart';

class FarmerHome extends StatefulWidget {
  FarmerHome({Key key}) : super(key: key);

  @override
  _FarmerHomeState createState() => _FarmerHomeState();
}

class _FarmerHomeState extends State<FarmerHome> {
  int ec = 0;
  String temp;
  String moisture;
  String growth = "Initial";
  bool isMainLoading = true;
  bool iscalLoading = false;
  String temperature;
  String growth_stage;
  String ans;
  String username;
  final firebase_auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    retriveValues();
  }

  retriveValues() async {
    setState(() {
      this.isMainLoading = true;
    });

    DocumentSnapshot doc = await Firestore.instance
        .collection("Sensor Values")
        .document("1")
        .get();
    temperature = doc.data['temp'].toString();
    temp = doc.data['temp'].toString();
    moisture = doc.data['moisture'].toString();

    final FirebaseUser user = await firebase_auth.currentUser();
    DocumentSnapshot userdata =
        await Firestore.instance.collection("users").document(user.uid).get();
    username = userdata.data['name'];

    setState(() {
      this.isMainLoading = false;
    });
  }

  Future<List> calculate(BuildContext ctx) async {
    setState(() {
      if (mounted) {
        this.iscalLoading = true;
      }
    });
    ec = ec ~/ 500;
    ec > 20 ? ec = 20 : ec = ec;
    print("Ec" + ec.toString());

    if (int.parse(temp) >= 35) {
      temp = "0";
    } else if (int.parse(temp) > 27 && int.parse(temp) < 35) {
      temp = "1";
    } else {
      temp = "2";
    }

    if (growth == "Initial") {
      growth_stage = "0";
    } else if (growth == "Mid") {
      growth_stage = "1";
    } else {
      growth_stage = "2";
    }

    print(ec.toString());
    Response res =
        await http.post("https://major-project-mlmodel-api.herokuapp.com",
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              'EC': ec,
              'Temp': temp,
              'Moisture': moisture,
              'Growth': growth_stage,
            }));

    if (res.statusCode == 200) {
      print(res
          .body); // complete by parsing the json body return into ExampleData object and return
      //.................
      setState(() {
        if (mounted) {
          this.iscalLoading = false;
        }
      });
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => LeachingOut(
            res.body,
          ),
        ),
      );
    } else {
      print(res.statusCode);
      print("Failed to get Data");
      setState(() {
        if (mounted) {
          this.iscalLoading = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isMainLoading == true
          ? WillPopScope(
              onWillPop: () {
                return new Future(() => false);
              },
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Color.fromRGBO(83, 131, 150, 1),
                  title: Text(" "),
                ),
                body: Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.green,
                )),
              ),
            )
          : WillPopScope(
              onWillPop: () {
                return new Future(() => false);
              },
              child: Scaffold(
                  drawer: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        Container(
                          height: 185,
                          child: DrawerHeader(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 28,
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    username,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(83, 131, 150, 1),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.home_outlined,
                            size: 32,
                            color: Color.fromRGBO(83, 131, 150, 1),
                          ),
                          title: Text('Home',
                              style: TextStyle(
                                fontSize: 19,
                              )),
                          onTap: () => {Navigator.of(context).pop()},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.verified_user_outlined,
                            size: 29,
                            color: Color.fromRGBO(83, 131, 150, 1),
                          ),
                          title:
                              Text('Profile', style: TextStyle(fontSize: 19)),
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            )
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.call,
                            size: 29,
                            color: Color.fromRGBO(83, 131, 150, 1),
                          ),
                          title: Text('Contact Us',
                              style: TextStyle(fontSize: 19)),
                          onTap: () => {Navigator.of(context).pop()},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.exit_to_app,
                            size: 29,
                            color: Color.fromRGBO(83, 131, 150, 1),
                          ),
                          title: Text('Logout', style: TextStyle(fontSize: 19)),
                          onTap: () => {Navigator.of(context).pop()},
                        ),
                      ],
                    ),
                  ),
                  appBar: AppBar(
                    //  title: Center(child: Text("")),
                    backgroundColor: Color.fromRGBO(83, 131, 150, 1),

                    //automaticallyImplyLeading: false,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 100.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                            color: Color.fromRGBO(83, 131, 150, 1),
                            boxShadow: [new BoxShadow(blurRadius: 0.0)],
                            borderRadius: new BorderRadius.vertical(
                                bottom: new Radius.elliptical(
                                    MediaQuery.of(context).size.width, 100.0)),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 20, 70, 5),
                                child: Text(
                                  "Welcome User",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("Manage all things at one place",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 20, 10),
                                          child: Icon(
                                            Icons.insert_chart_outlined,
                                            color: Colors.green,
                                            size: 40,
                                          ),
                                        ),
                                        SizedBox(
                                            width: 75,
                                            child: TextFormField(
                                              cursorColor: Colors.black,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              onChanged: (input) => {
                                                print(input),
                                                print(ec),
                                                ec = num.tryParse(input)
                                              },
                                              //onSaved: (input) =>
                                              // ec = num.tryParse(input),
                                              decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 0,
                                                          bottom: 11,
                                                          top: 11,
                                                          right: 10),
                                                  hintText: "Enter EC"),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 0),
                                      child: Text(
                                        "Electric Conductivity",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 40, 10),
                                          child: Icon(
                                            Icons.wb_sunny_outlined,
                                            color: Colors.orange,
                                            size: 40,
                                          ),
                                        ),
                                        Text(
                                          temperature + "°C",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          36, 0, 36, 0),
                                      child: Text(
                                        "Temperature",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 30, 10),
                                          child: Image.asset(
                                            "assets/images/moisture.jpg",
                                            height: 55,
                                          ),
                                        ),
                                        Text(
                                          moisture.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          36, 0, 36, 0),
                                      child: Text(
                                        "Soil Moisture",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 5, 10),
                                          child: Image.asset(
                                            "assets/images/growth.jpg",
                                            height: 48,
                                          ),
                                        ),
                                        DropdownButton<String>(
                                          value: growth,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              growth = newValue;
                                            });
                                          },
                                          items: <String>[
                                            "Initial",
                                            "Mid",
                                            "Late",
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 0, 40, 10),
                                      child: Text(
                                        "Growth Stage",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        this.iscalLoading == true
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () => calculate(context),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(83, 131, 150, 1)),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Text(
                                    "Calculate",
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ))
                      ],
                    ),
                  )),
            ),
    );
  }
}

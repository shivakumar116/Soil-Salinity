import 'dart:ui';

import 'package:Soil_Salinity/AddUser.dart';
import 'package:Soil_Salinity/LoginPage.dart';
import 'package:Soil_Salinity/ManageSensors.dart';
import 'package:Soil_Salinity/ManageUsers.dart';
import 'package:Soil_Salinity/viewtickets.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  manageusers() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageUsers(),
      ),
    );
  }

  managesensors() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageSensors(),
      ),
    );
  }

  pushtoadduser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUser(),
      ),
    );
  }

  pushtomanageuser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageUsers(),
      ),
    );
  }

  pushtomanagedevices() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageSensors(),
      ),
    );
  }

  logout() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  pushtohomesupport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageSensors(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return WillPopScope(
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
                            color: Colors.blue[300],
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Admin",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home_outlined,
                  size: 32,
                  color: Colors.black,
                ),
                title: Text('Home',
                    style: TextStyle(
                      fontSize: 19,
                    )),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  size: 29,
                  color: Colors.black,
                ),
                title: Text('Logout', style: TextStyle(fontSize: 19)),
                onTap: () => logout(),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Center(child: Text("")),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 150.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                    color: Colors.black87,
                    boxShadow: [new BoxShadow(blurRadius: 0.0)],
                    borderRadius: new BorderRadius.vertical(
                        bottom: new Radius.elliptical(
                            MediaQuery.of(context).size.width, 100.0)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 20, 70, 5),
                          child: Text(
                            "Welcome Admin",
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        pushtoadduser();
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 90, 10),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 20,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.person_add_alt,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      pushtoadduser();
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 7, 56, 10),
                                child: Text(
                                  "Add User",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 7, 8, 8),
                                child: Text(
                                  "Create user with email \nand password",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        pushtomanageuser();
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 90, 10),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 20,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.person_add_alt,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      pushtomanageuser();
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 7, 8, 10),
                                child: Text(
                                  "Manage Users",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 7, 8, 8),
                                child: Text(
                                  "View or Delete user \nfrom the database",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        pushtomanagedevices();
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 90, 10),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 20,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.person_add_alt,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      pushtomanagedevices();
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 7, 2, 10),
                                child: Text(
                                  "Active Devices",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 7, 8, 8),
                                child: Text(
                                  "View and Manage IOT \nsensors",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewTickets(),
                          ),
                        ),
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 90, 10),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 20,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.help_outline,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 7, 15, 10),
                                child: Text(
                                  "Help & Support",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 7, 6, 8),
                                child: Text(
                                  "View all pending tickets\nraised by users",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

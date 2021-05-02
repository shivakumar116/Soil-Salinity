import 'dart:ui';

import 'package:Soil_Salinity/AdminHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:toast/toast.dart';
import 'main.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();

class AddUser extends StatefulWidget {
  AddUser({Key key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String name;
  String email;
  String phonenumber;
  String password;
  int device_value;
  var _formKey = GlobalKey<FormState>();
  bool clickedonsignup = false;
  final _auth = FirebaseAuth.instance;

  bool check() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return false;
    } else {
      _formKey.currentState.save();
      return true;
    }
  }

  void addusertodb() async {
    setState(() {
      this.clickedonsignup = true;
    });
    if (check()) {
      try {
        AuthResult authresult;

        authresult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        Firestore.instance
            .collection('users')
            .document(authresult.user.uid)
            .setData({
          'email': email,
          'phonenumber': phonenumber,
          'uid': authresult.user.uid,
          'name': name,
          'device_id': "device1"
        });

        authresult.user.sendEmailVerification();
        Toast.show("User Created Successfully !!!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminHome(),
          ),
        );

// Find the Scaffold in the widget tree and use it to show a SnackBar.

        print('User created');
      } catch (e) {
        setState(() {
          clickedonsignup = false;
        });
        if (e.toString().contains(
            "The email address is already in use by another account")) {
          final snackBarr = SnackBar(content: Text("Email already in use"));
          _scaffoldKey.currentState.showSnackBar(snackBarr);
        } else if (e.toString().contains("ERROR_WEAK_PASSWORD")) {
          final snackBarr = SnackBar(content: Text("Password is too weak"));
          _scaffoldKey.currentState.showSnackBar(snackBarr);
        } else {
          final snackBarr = SnackBar(content: Text(e.toString()));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
          _scaffoldKey.currentState.showSnackBar(snackBarr);
          print('Error: $e');
        }
      }
    } else {
      setState(() {
        clickedonsignup = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "Add User",
            style: TextStyle(
              fontSize: 19,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Name ',
                    ),
                    onSaved: (String value) {
                      this.name = value;
                    },
                    validator: (String value) {
                      return (value.length == 0)
                          ? 'Name Cannot be blank'
                          : null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email_outlined),
                      labelText: 'Email ',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      this.email = value;
                    },
                    validator: (value) {
                      if (value.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone_sharp),
                      labelText: 'Phone Number ',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      this.phonenumber = value;
                    },
                    validator: (String value) {
                      return (value.length != 10)
                          ? 'Phone number must be 10 digits'
                          : null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    cursorHeight: 25,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock_outline),
                      labelText: 'Password ',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      this.password = value;
                    },
                    validator: (String value) {
                      return (value.length < 6)
                          ? 'Password Must be >6 characters'
                          : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: DropdownButton<int>(
                      value: device_value,
                      onChanged: (int newValue) {
                        setState(() {
                          device_value = newValue;
                        });
                      },
                      items: <int>[1, 2, 3].map((int value) {
                        return new DropdownMenuItem<int>(
                          value: value,
                          child: new Text(device_value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  clickedonsignup == true
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => addusertodb(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              "Add User",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

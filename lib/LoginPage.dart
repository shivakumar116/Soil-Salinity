import 'dart:ui';

import 'package:Soil_Salinity/AdminHome.dart';
import 'package:Soil_Salinity/FarmerHome.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  adminlogin() {
    //Firestore.instance.collection("Shiva").add({'name': 'shiva'});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AdminHome(),
      ),
    );
  }

  farmerlogin() {
    //Firestore.instance.collection("Shiva").add({'name': 'shiva'});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FarmerHome(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/art_farmer.png",
                height: 200,
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () => adminlogin(),
                child: Text(
                  '  ADMIN LOGIN   ',
                  style: TextStyle(),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              ElevatedButton(
                onPressed: () => farmerlogin(),
                child: Text(' FARMER LOGIN '),
              )
            ],
          ),
        ),
      ),
    );
  }
}

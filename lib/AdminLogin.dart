import 'package:Soil_Salinity/AdminHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  AdminLogin({Key key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var _formKey = GlobalKey<FormState>();
  bool clickedonadminlogin = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  bool check() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return false;
    } else {
      _formKey.currentState.save();
      return true;
    }
  }

  void login() {
    setState(() {
      this.clickedonadminlogin = true;
    });
    if (check()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminHome(),
        ),
      );
    } else {
      setState(() {
        this.clickedonadminlogin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Admin Login"),
          backgroundColor: Colors.black,
          centerTitle: true,
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
                  SizedBox(
                    height: 35,
                  ),
                  clickedonadminlogin == true
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => login(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              "Login",
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

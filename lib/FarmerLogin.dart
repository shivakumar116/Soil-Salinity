import 'package:Soil_Salinity/FarmerHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class FarmerLogin extends StatefulWidget {
  FarmerLogin({Key key}) : super(key: key);

  @override
  _FarmerLoginState createState() => _FarmerLoginState();
}

class _FarmerLoginState extends State<FarmerLogin> {
  var _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool clickedonfarmerlogin = false;
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

  void farmerlogin(BuildContext context) async {
    if (check()) {
      setState(() {
        this.clickedonfarmerlogin = true;
      });
      print(this.email + '' + this.password);

      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                print(value.user.isEmailVerified),
                if (value.user.isEmailVerified)
                  {
                    print(value.user.isEmailVerified),
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FarmerHome(),
                      ),
                    )
                  }
                else
                  {
                    FirebaseAuth.instance.signOut(),
                    setState(() {
                      this.clickedonfarmerlogin = false;
                    }),
                    Toast.show("You must verify you email...", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM)
                  }
              })
          .catchError((onError) {
        setState(() {
          this.clickedonfarmerlogin = false;
        });
        print(onError);

        if (onError.toString().contains("ERROR_USER_NOT_FOUND")) {
          final snackBarr = SnackBar(content: Text("User doesn't exist"));
          _scaffoldKey.currentState.showSnackBar(snackBarr);
          print("User Not Found");
        } else if (onError.toString().contains("ERROR_WRONG_PASSWORD")) {
          final snackBarr =
              SnackBar(content: Text("Wrong or Inavlid Password"));
          _scaffoldKey.currentState.showSnackBar(snackBarr);
        } else {
          final snackBarr = SnackBar(content: Text(onError.toString()));
          _scaffoldKey.currentState.showSnackBar(snackBarr);
        }
      });
    } else {
      setState(() {
        this.clickedonfarmerlogin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Farmer Login"),
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
                  clickedonfarmerlogin == true
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => farmerlogin(context),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
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

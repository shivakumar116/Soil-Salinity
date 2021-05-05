import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'FarmerHome.dart';

class ContactUS extends StatefulWidget {
  ContactUS({Key key}) : super(key: key);

  @override
  _ContactUSState createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  String title;
  bool clickedonfarmerlogin = false;
  var _formKey = GlobalKey<FormState>();
  String subject;
  String description;

  @override
  bool check() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return false;
    } else {
      _formKey.currentState.save();
      return true;
    }
  }

  void submitquery() async {
    setState(() {
      this.clickedonfarmerlogin = true;
    });
    if (check()) {
      try {
        final FirebaseUser user = await firebase_auth.currentUser();
        DocumentSnapshot userdata = await Firestore.instance
            .collection("users")
            .document(user.uid)
            .get();

        Firestore.instance.collection('Tickets').document().setData({
          'email': userdata.data['email'],
          'phone': userdata.data['phonenumber'],
          'name': userdata.data['name'],
          'subject': subject,
          'description': description
        });

        Toast.show("Submitted Successfully !!!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FarmerHome(),
          ),
        );

// Find the Scaffold in the widget tree and use it to show a SnackBar.

        print('User created');
      } catch (e) {
        setState(() {
          this.clickedonfarmerlogin = false;
        });
      }
    } else {
      setState(() {
        this.clickedonfarmerlogin = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(83, 131, 150, 1),
          title: Text("Contact Us"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (String value) {
                      return (value.length == 0)
                          ? 'Subject Cannot be blank'
                          : null;
                    },
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      this.subject = value;
                    },
                    minLines: 1,
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Subject',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (String value) {
                      return (value.length == 0) ? 'Description is must' : null;
                    },
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      this.description = value;
                    },
                    minLines: 4,
                    maxLines: 7,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                clickedonfarmerlogin == true
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => submitquery(),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(83, 131, 150, 1)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            "Submit",
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
    );
  }
}

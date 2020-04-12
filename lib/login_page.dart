import 'package:clothingfinder/image_selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'registerPage.dart';
import 'package:clothingfinder/Home_Page.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';


class LoginPage extends StatefulWidget {
  @override
  _pageState createState() => _pageState();
}

class _pageState extends State<LoginPage> {
  String name;
  String password;

  TextEditingController nameController;
  TextEditingController passwordController;

  GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
    nameController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.length < 8) {
      return "Password must be longer than 8 characters";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/ecocycle.gif"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter)),
        child: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 320),
              Form(
                key: _loginFormKey,
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 19.0, top: 60.0, right: 19.0),
                    height: 300.0,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                              30.0) //         <--- border radius here
                          ),
                    ),
                    child: new Directionality(
                        textDirection: TextDirection.ltr,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 30),
                            new TextFormField(
                              controller: nameController,
                              autofocus: false,
                              style: new TextStyle(
                                  fontSize: 22.0, color: Color(0xFFbdc6cf)),
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Username',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            new TextFormField(
                              controller: passwordController,
                              autofocus: false,
                              style: new TextStyle(
                                  fontSize: 22.0, color: Color(0xFFbdc6cf)),
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Password',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (text) {
                                password = text;
                              },
                            ),
                            SizedBox(height: 20),
                            FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)),
                              color: Colors.redAccent,
                              textColor: Colors.white,
                              padding: EdgeInsets.all(20.0),
                              child: Text('    Login    '),
                              onPressed: () {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: nameController.text,
                                        password: passwordController.text)
                                    .then((value) => {
                                          Firestore.instance
                                              .collection('users')
                                              .document(value.user.uid)
                                              .get()
                                              .then((value) => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()),
                                                  ))
                                        });
                              },
                            ),
                            SizedBox(height: 9),
                            MaterialButton(
                              minWidth: 100,
                              height: 50,

                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                              child: Text(
                                    "Sign Up / Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "CentraleSansRegular",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                            ),
                          ],
                        ))),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

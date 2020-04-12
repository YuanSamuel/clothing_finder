import 'package:clothingfinder/image_selection.dart';
import 'package:clothingfinder/upload_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'camera.dart';
import 'registerPage.dart';
import 'package:clothingfinder/Home_Page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UploadPage(),
  ));
}

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
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(height: 100),
            Text("EcoCycle"),
            SizedBox(height: 260),
            Form(
              key: _loginFormKey,
              child: Container(
                  margin:
                  const EdgeInsets.only(left: 30.0, top: 60.0, right: 30.0),
                  height: 170.0,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      new BorderRadius.all(new Radius.circular(25.7))),
                  child: new Directionality(
                      textDirection: TextDirection.ltr,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text('Login'),
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
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                            ),
                          ),
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
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                            ),
                            onChanged: (text) {
                              password = text;
                            },
                          ),
                          FlatButton(
                            child: Text(
                                'Submit'
                            ),
                            onPressed: () {
                              FirebaseAuth.instance.signInWithEmailAndPassword(email: nameController.text, password: passwordController.text).then((value) => {
                                Firestore.instance.collection('users').document(value.user.uid).get().then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                ))
                              });
                            },
                          ),
                        ],
                      ))),
            ),
            RaisedButton(
              child: Text(
                  "Brand new? Let's register!"
              ),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
            )
          ],
        )
      ]),
    );
  }
}
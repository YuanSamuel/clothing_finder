import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'image_selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clothingfinder/Home_Page.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String newName;
  String newPassword;

  GlobalKey<FormState> _registerFormKey = new GlobalKey<FormState>();

  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passwordController;

  void initState() {
    super.initState();
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  void submitInfo() async {
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
        Firestore.instance.collection('users').document(value.user.uid).setData({
          'name': nameController.text,
          'email': emailController.text,
          'uid': value.user.uid,
          'points': 0,
          'posts': [],
          'ratings': 0,
          'rated': [],
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        nameController.clear();
        emailController.clear();
        passwordController.clear();
    });
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
      return 'Password must be longer than 8 characters';
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/reusify.gif"),
    fit: BoxFit.cover,
    alignment: Alignment.topCenter)),
    child: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(height: 100),
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            Form(
              key: _registerFormKey,
              child: Container(
                  margin:
                  const EdgeInsets.only(left: 30.0, top: 60.0, right: 30.0),
                  decoration: new BoxDecoration(
                      borderRadius:
                      new BorderRadius.all(new Radius.circular(25.7))),
                  child: new Directionality(
                      textDirection: TextDirection.ltr,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          new TextFormField(
                            controller: nameController,
                            autofocus: false,
                            style: new TextStyle(
                                fontSize: 22.0, color: Colors.black),
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Name',
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
                          ), SizedBox(height: 10),
                          new TextFormField(
                            controller: emailController,
                            autofocus: false,
                            style: new TextStyle(
                                fontSize: 22.0, color: Colors.black),
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Your Email',
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (text) {
                              newName = text;
                            },
                            validator: emailValidator,
                          ),
                          SizedBox(height: 10),
                          new TextFormField(
                            controller: passwordController,
                            autofocus: false,
                            style: new TextStyle(
                                fontSize: 22.0, color: Colors.black),
                                obscureText: true,
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Pick a Password',
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (text) {
                              newPassword = text;
                            },
                            validator: passwordValidator,
                          ),
                          Container(
                            height: 15,
                          ),
                          FlatButton(
                            child: Container(
                              alignment: Alignment.center,
                              child: Container(
                                child: Text(
                                  'Submit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [Color.fromRGBO(122, 124, 255, 1), Color.fromRGBO(48, 79, 254, 1)]),
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            onPressed: () {
                              submitInfo();
                              print("submitted");
                            },
                          ),
                          FlatButton(onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Login',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),))
                        ],
                      ))),
            ),

          ],
        )
      ]),)
    );
  }
}
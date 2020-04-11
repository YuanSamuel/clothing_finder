import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String newName;
  String newPassword;

  TextEditingController nameController;
  TextEditingController passwordController;

  void initState() {
    super.initState();
    nameController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(height: 100),
            Text("RegisterPage"),
            SizedBox(height: 260),
            Container(
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
                        Text('Register'),
                        new TextField(
                          controller: null,
                          autofocus: false,
                          style: new TextStyle(
                              fontSize: 22.0, color: Color(0xFFbdc6cf)),
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Pick a Username',
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
                            newName = text;
                          },
                        ),

                        new TextField(
                          controller: null,
                          autofocus: false,
                          style: new TextStyle(
                              fontSize: 22.0, color: Color(0xFFbdc6cf)),
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Pick a Password',
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
                            newPassword = text;
                          },
                        ),
                        FlatButton(
                          child: Text(
                              'Submit'
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ))),
            RaisedButton(
              child: Text(
                  "Alrighty, let's login!"
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        )
      ]),
    );
  }
}

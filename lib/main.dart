import 'package:flutter/material.dart';
import 'registerPage.dart';
import 'RatingPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RatingPage(),
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
            Text("EcoCycle"),
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
                        Text('Login'),
                        new TextField(
                          controller: null,
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
                          onChanged: (text) {
                            name = text;
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
                          onPressed: () {},
                        ),
                      ],
                    ))),
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

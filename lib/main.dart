import 'package:flutter/material.dart';
import 'registerPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
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
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Column(children: <Widget>[

                    TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(fontSize: 24),
                            border: InputBorder.none,
                            hintText: 'username',
                            labelText: "Enter your username"),
                        onChanged: (text) {
                          print("Second text field: $text");

                          setState(() {
                            name = text;
                          });
                        }),
                    //Name

                    //password
                    TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(fontSize: 24),
                            border: InputBorder.none,
                            hintText: 'password',
                            labelText: "Enter your password"),
                        onChanged: (text) {
                          print("Second text field: $text");

                          setState(() {
                            password = text;
                          });
                        }),
                    FlatButton(
                      child: Text('register'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()));
                      },

                    )
              ]))
            ],
          )
        ],
      ),
    );
  }
}

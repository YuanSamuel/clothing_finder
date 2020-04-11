import 'package:flutter/material.dart';
import 'main.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(fontSize: 24),
                            border: InputBorder.none,
                            hintText: 'username',
                            labelText: "Enter your new username"),
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
                            labelText: "Enter your new password"),
                        onChanged: (text) {
                          print("Second text field: $text");

                          setState(() {
                            name = text;
                          });
                        }),
                    FlatButton(
                      child: Text('login'),
                      onPressed: () {
                        Navigator.pop(context);
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

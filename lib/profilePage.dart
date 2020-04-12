import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: Center(
                child: Text('Loading...'),
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/BackgroundTwo.PNG'),
                      fit: BoxFit.cover)),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 225),
                        Text('Profile',
                            style: TextStyle(
                                fontSize: 32,
                                fontStyle: FontStyle.italic,
                                color: Colors.white)),
                        SizedBox(height: 10),
                        Text(
                          snapshot.data.data['name'],
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(height: 50),

                        //Total Posts
                        Text(
                          'Total Posts',
                          style: TextStyle(
                              fontSize: 32,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          snapshot.data.data['posts'].length.toString(),
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(height: 50),
                        //Total Points
                        Text(
                          'Total Points',
                          style: TextStyle(
                              fontSize: 32,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          snapshot.data.data['points'].toString(),
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(height: 50),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        });
  }

  Future<DocumentSnapshot> getUserInfo() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .get();
  }
}

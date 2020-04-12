import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingPage extends StatefulWidget {
  RatingPage({Key key, this.posts}) : super(key: key);
  final List<DocumentSnapshot> posts;
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
    future: getUserPosts(),
    builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return Scaffold(
          body: CircularProgressIndicator(),
        );
      }
      else {
        widget.posts.sort((a, b) {
          return a.data['votes'].compareTo(b.data['votes']);
        });
        for (int i = 0; i < widget.posts.length; i++) {
          if (widget.posts[i].data['userId'] != snapshot.data.data['uid'] && snapshot.data.data['rated'].contains(widget.posts[i].documentID)) {
            return Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Rating Page',
                    style: TextStyle(
                        fontStyle: FontStyle.italic
                    ),
                  )
              ),
              body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(32, 32, 32, 12),
                        child: Container(
                          child: Image.network(widget.posts[i].data['url']),
                          height: MediaQuery.of(context).size.height / 1.2,
                          width: MediaQuery.of(context).size.width / 1.2,
                        ),
                      ),
                      RatingBar(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 32,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(height: 6),
                      ButtonTheme(
                        minWidth: 200,
                        height: 40,
                        child: RaisedButton(
                          child: Text(
                            'Confirm Rating',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22
                            ),
                          ),
                          color: Colors.amber,
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        }
        return Scaffold(
          body: Center(
            child: Text('Nothing to vote for!'),
          )
        );
      }
    });
  }

  Future<DocumentSnapshot> getUserPosts() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return Firestore.instance.collection('users').document(user.uid).get();
  }
}

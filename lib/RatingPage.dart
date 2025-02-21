import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'models/entry.dart';

class RatingPage extends StatefulWidget {
  RatingPage({Key key, this.posts}) : super(key: key);
  final List<DocumentSnapshot> posts;
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {

  double stars;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: getUserPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                  ),
                ),
              ),
            );
          } else {
            widget.posts.sort((a, b) {
              return a.data['votes'].compareTo(b.data['votes']);
            });
            for (int i = 0; i < widget.posts.length; i++) {
              entry post = entry.fromSnapshot(widget.posts[i]);
              if (post.userId != snapshot.data.data['uid'] &&
                  !snapshot.data.data['rated']
                      .contains(widget.posts[i].documentID)) {
                print('return');
                return Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: Colors.white,
                      centerTitle: true,
                      title: Text(
                        'Rating Page',
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                      )),
                  body: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/reuse.gif"),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter)),
                    child: SizedBox.expand(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          post.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "CentraleSansRegular",
                              fontSize: 35,
                              fontWeight: FontWeight.w700
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
                          child: Text(
                            post.description,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "CentraleSansRegular",
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                            ),
                          ),),
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 15),
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(40),
                                topRight: const Radius.circular(40),
                                bottomLeft: const Radius.circular(40),
                                bottomRight: const Radius.circular(40),
                              ),
                            ),
                            child: Image.network(
                             post.url,
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: MediaQuery.of(context).size.width / 1.2,
                            ),
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
                            stars = rating;
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            color: Colors.amber,
                            onPressed: () {
                              updatePoints(snapshot.data, post);
                            },
                          ),
                        )
                      ],
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                  )
                );
              }
            }
            return Scaffold(
                body: Center(
              child: Text('Nothing to vote for!'),
            ));
          }
        });
  }

  updatePoints(DocumentSnapshot currentUserData, entry post) async {
    List rated = currentUserData.data['rated'];
    rated.add(post.reference.documentID);
    currentUserData.reference.updateData({
      'points': currentUserData.data['points'] + 1,
      'ratings': currentUserData.data['ratings'] + 1,
      'rated': rated,
    });
    DocumentSnapshot otherUser = await Firestore.instance.collection('users').document(post.userId).get();
    Firestore.instance.collection('users').document(post.userId).updateData({
      'points': otherUser.data['points'] + (stars - 2),
    });
    Firestore.instance.collection('posts').document(post.reference.documentID).updateData({
      'rating': (post.rating * post.votes + stars) / (post.votes + 1),
      'votes': post.votes + 1,
    });
    Navigator.pop(context);
  }

  Future<DocumentSnapshot> getUserPosts() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return Firestore.instance.collection('users').document(user.uid).get();
  }
}

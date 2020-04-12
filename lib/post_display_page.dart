import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'models/entry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PostDisplayPage extends StatefulWidget {
  PostDisplayPage({Key key, this.passedEntry}) : super(key: key);
  final entry passedEntry;
  @override
  _PostDisplayPageState createState() => _PostDisplayPageState();
}

class _PostDisplayPageState extends State<PostDisplayPage> {
  double stars;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(widget.passedEntry.userName,style: TextStyle(color: Colors.black),),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: getUserPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Scaffold(
                body: Center(child: Text('Loading')),
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 10,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width /1.5,
                            child: Text(
                            widget.passedEntry.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "CentraleSansRegular",
                                fontSize: 35,
                                fontWeight: FontWeight.w500
                            ),),),),
                          SizedBox(width: MediaQuery.of(context).size.width / 20,),
                          Icon(Icons.star),
                          Text('${widget.passedEntry.rating.round()}/5', style: TextStyle(fontSize: 20),),
                          Container(
                            width: 10,
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Text(widget.passedEntry.description, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), textAlign: TextAlign.left,),)
                      ),
                      Image.network(widget.passedEntry.url,
                          height: MediaQuery.of(context).size.height / 1.5),
                      !snapshot.data.data['rated'].contains(widget.passedEntry.reference.documentID) ?
                          Padding(padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              RatingBar(
                                itemCount: 5,
                                onRatingUpdate: (rating) {
                                  stars = rating;
                                },
                                maxRating: 5,
                                minRating: 1,
                                allowHalfRating: false,
                                initialRating: 3,
                                itemBuilder: (context, _) {
                                  return Icon(Icons.star, color: Color.fromRGBO(252, 186, 3, 1),);
                                },
                              ),
                              Spacer(
                                flex: 4,
                              ),
                              FlatButton(
                                color: Color.fromRGBO(252, 186, 3, 1),
                                child: Text(
                                    'Submit'
                                ),
                                onPressed: () async {
                                  await Firestore.instance.collection('posts').document(widget.passedEntry.reference.documentID).updateData({
                                    'rating': (widget.passedEntry.rating * widget.passedEntry.votes + stars) / (widget.passedEntry.votes + 1),
                                    'votes': widget.passedEntry.votes + 1,
                                  });
                                  List rated = snapshot.data.data['rated'];
                                  rated.add(widget.passedEntry.reference.documentID);
                                  await snapshot.data.reference.updateData({
                                    'rated': rated,
                                    'ratings': snapshot.data.data['ratings'] + 1,
                                    'points': snapshot.data.data['points'] + 1,
                                  });
                                  DocumentSnapshot otherUser = await Firestore.instance.collection('users').document(widget.passedEntry.userId).get();
                                  await otherUser.reference.updateData({
                                    'points': otherUser.data['points'] + (stars - 2),
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              Spacer(
                                flex: 2,
                              ),
                            ],
                          )) : SizedBox.shrink(),
                    ],
                    scrollDirection: Axis.vertical,
                  ),
              );
            }
          }),
    );
  }

  Future<DocumentSnapshot> getUserPosts() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .get();
  }
}

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
        title: const Text('Post Preview'),
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
                child: SizedBox.expand(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.passedEntry.userName,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "CentraleSansRegular",
                              fontSize: 29,
                              fontWeight: FontWeight.bold
                          ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.passedEntry.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "CentraleSansRegular",
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                          SizedBox(width: MediaQuery.of(context).size.width / 20,),
                          Icon(Icons.star),
                          Text('${widget.passedEntry.rating.round()}/5',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "CentraleSansRegular",
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),)
                        ],
                      ),
                      Image.network(widget.passedEntry.url,
                          height: MediaQuery.of(context).size.height / 1.5),
                      Text(widget.passedEntry.description,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "CentraleSansRegular",
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),),
                      !snapshot.data.data['rated'].contains(widget.passedEntry.reference.documentID) ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Vote!'),
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
                                  return Icon(Icons.star);
                                },
                              ),
                              FlatButton(
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
                                  setState(() {

                                  });
                                },
                              )
                            ],
                          ) : SizedBox.shrink(),
                    ],
                  ),
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

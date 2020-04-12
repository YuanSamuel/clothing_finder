import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_crop/image_crop.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
          ),
          Container(
            child: StreamBuilder(
                stream: Firestore.instance.collection('posts').snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Text('Loading data');
                  }
                  return Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width-50,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                      ),
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          child: Text(
                                            'Person',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10,right: 10,bottom: 5),
                              child: Container(
                                child: Text('Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah'),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width-70,
                              height: 9*(MediaQuery.of(context).size.width-70)/16,
                              child: Image.asset('assets/example.jpg'),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: RatingBar(
                                    itemSize: 30,
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  )
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          )
                        ),
                      ),
                    ],
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}

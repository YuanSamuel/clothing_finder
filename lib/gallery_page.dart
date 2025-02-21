import 'package:clothingfinder/RatingPage.dart';
import 'package:clothingfinder/post.dart';
import 'package:clothingfinder/post_display_page.dart';
import 'package:clothingfinder/upload_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_crop/image_crop.dart';
import 'models/entry.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white])),
          child: ListView(children: <Widget>[
            Column(children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              Container(
                child: FutureBuilder(
                    future:
                        Firestore.instance.collection('posts').getDocuments(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Text('Loading data');
                      } else {
                        List<DocumentSnapshot> mostPopular =
                            snapshot.data.documents;
                        mostPopular.sort((a, b) {
                          return ((b.data['rating'] * 2 + b.data['votes']) - (a.data['rating'] * 2 + a.data['votes'])).floor();
                        });
                        List<DocumentSnapshot> mostRecent =
                            snapshot.data.documents;
                        mostRecent.sort((a, b) {
                          return b.data['time'] - a.data['time'];
                        });
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "        Most Popular Posts        ",
                              style: TextStyle(
                                  backgroundColor: Colors.blue[700],
                                  color: Colors.white,
                                  fontFamily: "CentraleSansRegular",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Container(
                              color: Colors.lightBlueAccent[5],
                              height: MediaQuery.of(context).size.height / 3,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, int i) {
                                    return Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 7,
                                        ),
                                        createPost(entry
                                            .fromSnapshot(mostPopular[i])),
                                        SizedBox(
                                          width: 7,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                backgroundColor: Colors.red,
                                  color: Colors.black,
                                  fontFamily: "CentraleSansRegular",
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "        Latest Posts        ",
                              style: TextStyle(
                                  backgroundColor: Colors.blue[700],
                                  color: Colors.white,
                                  fontFamily: "CentraleSansRegular",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),Text(
                              "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "CentraleSansRegular",
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),

                            Container(
                              color: Colors.lightBlueAccent[5],
                              height: MediaQuery.of(context).size.height / 2.9,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, int i) {
                                    return Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 7,
                                        ),
                                        createPost(
                                            entry.fromSnapshot(mostRecent[i])),
                                        SizedBox(
                                          width: 7,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        );
                      }
                    }),
              ),
            ])
          ])),
      floatingActionButton: FloatingActionButton(
        heroTag: "imageButton",
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UploadPage()));
          setState(() {

          });
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add),
      ),
    );
  }

  GestureDetector createPost(entry passedEntry) {
    print("create");
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostDisplayPage(passedEntry: passedEntry,)),
        );
        setState(() {

        });
      },
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5),
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
                                passedEntry.userName,
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
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(

                    child: Text(
                      passedEntry.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                if(passedEntry.description.length<=30)
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      child: Text(
                        passedEntry.description,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                if(passedEntry.description.length>30)
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      child: Text(
                        passedEntry.description.substring(0,27)+'...',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    height: MediaQuery.of(context).size.height/6,
                    color: Colors.lightBlueAccent,
                    child: AspectRatio(
                      aspectRatio: 16/9,
                      child: Image.network(
                        passedEntry.url,
                        height: MediaQuery.of(context).size.height / 6,
                        fit: BoxFit.cover,
                      ),
                    )
                ),),
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: RatingBar(
                        itemSize: MediaQuery.of(context).size.width / 15,
                        initialRating: passedEntry.rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        ignoreGestures: true,
                      )),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
          ),
        ],
      ),
    );
  }
}

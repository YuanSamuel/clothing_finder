import 'package:clothingfinder/RatingPage.dart';
import 'package:clothingfinder/upload_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_crop/image_crop.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'models/entry.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  File _image;
  String url;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });

    FirebaseStorage _storage = FirebaseStorage();
    String filePath = 'images/${DateTime.now()}.png';
    StorageUploadTask _uploadTask =
        _storage.ref().child(filePath).putFile(_image);
    await _uploadTask.onComplete;
    url = await _storage.ref().child(filePath).getDownloadURL();

    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UploadPage(
                url: url,
              )),
    );
    setState(() {

    });
  }

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
                height: 20,
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
                                  backgroundColor: Colors.black26,
                                  color: Colors.black,
                                  fontFamily: "CentraleSansRegular",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Container(
                              color: Colors.lightBlueAccent[5],
                              height: MediaQuery.of(context).size.height / 2.8,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, int i) {
                                    return Row(
                                      children: <Widget>[
                                        createPost(entry
                                            .fromJson(mostPopular[i].data)),
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
                                  backgroundColor: Colors.black26,
                                  color: Colors.black,
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
                                        createPost(
                                            entry.fromJson(mostRecent[i].data)),
                                        SizedBox(
                                          width: 5,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            Center(
                              child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.blue)),
                                color: Colors.blue,
                                textColor: Colors.white,
                                padding: EdgeInsets.all(15.0),
                                child: Text('Vote'),
                                onPressed: () {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RatingPage(
                                              posts: snapshot.data.documents,
                                            )),
                                  );
                                  setState(() {

                                  });
                                },
                              ),
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
        onPressed: () {
          getImage();
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Column createPost(entry passedEntry) {
    print("create");
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 2,
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
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Container(

                  child: Text(
                    passedEntry.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                color: Colors.lightBlueAccent,
                height: MediaQuery.of(context).size.height / 5.8,
                child: Image.network(
                  passedEntry.url,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Container(
                  child: Text(
                    passedEntry.description,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: RatingBar(
                      itemSize: MediaQuery.of(context).size.width / 15,
                      initialRating: passedEntry.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
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
    );
  }
}

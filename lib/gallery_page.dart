import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  return Post("lol","lol","assets/lol.jpg");
                }
            ),
          ),
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

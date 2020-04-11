import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: Firestore.instance.collection('posts').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Text('Loading data');
              }
              return Column(
                
              );
            }
          ),
      ),
    );
  }
}

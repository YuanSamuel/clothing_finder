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
                  return Post("Ronald Grump","What the fuck did you just fucking say about me, you little bitch? I’ll have you know I graduated top of my class in the Navy Seals, and I’ve been involved in secret raids on Al-Quaeda, and I have over 300 confirmed kills. I am trained in gorilla warfare and I’m the top sniper in the entire US armed forces. You are nothing to me but just another target. I will wipe you out with precision the likes of which has never been seen before on this Earth, mark my words. You think you can get away with saying shit to me over the Internet? Think again, fucker. As we speak I am contacting my network of spies across the USA and your IP is being traced right now so you better prepare for the storm, maggot. The storm that wipes out the pathetic little thing you call your life. You’re fucking dead, kid. I can be anywhere, anytime, and I can kill you in over seven hundred ways, and that’s just with my bare hands. Not only am I extensively trained in unarmed combat, but I have access to the entire arsenal of the United States Marine Corps and I will use it to its full extent to wipe your ass off the face of the continent, you little shit. If only you could have known what unholy retribution your little “clever” comment was about to bring down upon you, maybe you would have held your tongue. You didn’t, and now you’re paying the price, you goddamn idiot. I will shit all over you and you will drown in it. You’re fucking dead, kiddo.","assets/donald.png");
                }
            ),
          ),
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

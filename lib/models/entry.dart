import 'package:cloud_firestore/cloud_firestore.dart';

class entry {
  String name;
  String description;
  String url;
  String userId;
  double rating;
  int votes;
  String userName;
  int time;

  DocumentReference reference;

  entry({this.name, this.description, this.url, this.userId, this.rating, this.votes, this.reference, this.userName, this.time});

  factory entry.fromSnapshot(DocumentSnapshot snapshot) {
    entry newEntry = entry.fromJson(snapshot.data);
    newEntry.reference = snapshot.reference;
    return newEntry;
  }

  factory entry.fromJson(Map<String, dynamic> json) => entry(
    name: json['name'] as String,
    description: json['description'] as String,
    url: json['url'] as String,
    userId: json['userId'] as String,
    rating: json['rating'] as double,
    votes: json['votes'] as int,
    userName: json['userName'] as String,
    time: json['time'] as int,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': this.name,
    'description': this.description,
    'url': this.url,
    'userId': this.userId,
    'rating': this.rating,
    'votes': this.votes,
    'userName': this.userName,
    'time': this.time,
  };
}
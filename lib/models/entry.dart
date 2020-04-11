import 'package:cloud_firestore/cloud_firestore.dart';

class entry {
  String name;
  String description;
  String url;
  String userId;
  double rating;
  int votes;

  DocumentReference reference;

  entry({this.name, this.description, this.url, this.userId, this.rating, this.votes});

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
  );

  Map<String, dynamic> _entryToJson(entry instance) => <String, dynamic>{
    'name': instance.name,
    'description': instance.description,
    'url': instance.url,
    'userId': instance.userId,
    'rating': instance.rating,
    'votes': instance.votes,
  };
}
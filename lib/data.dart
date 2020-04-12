import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  String _id;
  final CollectionReference dataCollection = Firestore.instance.collection('user');

  DatabaseService(id) {
    _id = id;
  }

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://recycle-f9250.appspot.com");

  StorageUploadTask _uploadTask;

  void _startUpload() {

  }

  Future<bool> handleSignInEmail(String id, String password) async {

    AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: id, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');

    return true;

  }


}
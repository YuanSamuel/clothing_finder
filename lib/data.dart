import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  String _id;
  final CollectionReference dataCollection = Firestore.instance.collection('user');

  DatabaseService(id) {
    _id = id;
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
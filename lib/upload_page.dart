import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'models/entry.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key key}) : super(key: key);
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  TextEditingController descriptionController;
  TextEditingController titleController;
  File _image;
  String url;

  @override
  void initState() {
    super.initState();
    descriptionController = new TextEditingController();
    titleController = new TextEditingController();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImageDevice() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context, () {
                            setState(() {

                            });
                          });
                        },
                        child: Icon(Icons.clear, size: 30, color: Color.fromRGBO(23, 67, 156, 1),)),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  FlatButton(
                      onPressed: () async {
                        FirebaseStorage _storage = FirebaseStorage();
                        String filePath = 'images/${DateTime.now()}.png';
                        StorageUploadTask _uploadTask = _storage.ref().child(filePath).putFile(_image);
                        await _uploadTask.onComplete;

                        url = await _storage.ref().child(filePath).getDownloadURL();
                        addEntry();
                      },
                      child: Text('Upload', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color.fromRGBO(23, 67, 156, 1)),)),

                ],
              ),
              alignment: Alignment.bottomCenter,
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Container(
              height: MediaQuery.of(context).size.height-70,
              child: ListView(
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: new Container(
                      alignment: Alignment.topLeft,
                      height: 65,
                      child: TextFormField(
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            hintText: "Title", border: InputBorder.none),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: titleController,
                      ),
                    ),),
                  Padding(padding: EdgeInsets.all(10),
                    child: new Container(
                      alignment: Alignment.topLeft,
                      height: 150,
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            hintText: "Description", border: InputBorder.none),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: descriptionController,
                      ),
                    ),),
                  if(_image!=null)
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: new Container(
                      height: 300,
                      decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: new FileImage(_image),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0),
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0))),),),
                  if(_image==null)
                    Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                      child: new Container(
                        height: 300,
                        child: Center(
                          child: Text('Please Upload a Image File'),
                        ),
                        decoration: new BoxDecoration(
                          border: Border.all(color: Colors.black45),
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                                topRight: const Radius.circular(10.0),
                                bottomLeft: const Radius.circular(10.0),
                                bottomRight: const Radius.circular(10.0))),),),
                  Container(
                    height: 5,
                  ),
                  Padding(padding: EdgeInsets.only(right: 10, top: 10),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: FloatingActionButton(
                          heroTag: "UploadButton",
                          child: Icon(Icons.add_photo_alternate),
                          onPressed: () {
                            getImageDevice();
                          },
                        ),
                      ),
                    ),),
                  Padding(padding: EdgeInsets.only(right: 10, top: 10),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: FloatingActionButton(
                        heroTag: "AddPhotoButton",
                        child: Icon(Icons.add_a_photo),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                  ),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addEntry() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot getUser = await Firestore.instance.collection('users').document(user.uid).get();
    entry newEntry = entry(
        name: titleController.text,
        userId: user.uid,
        url: url,
        description: descriptionController.text,
        rating: 0,
        votes: 0,
        userName: getUser.data['name'],
        time: DateTime.now().millisecondsSinceEpoch,
    );
    DocumentReference uploadRef = await Firestore.instance.collection('posts').add(newEntry.toJson());
    DocumentSnapshot snap = await Firestore.instance.collection('users').document(user.uid).get();
    List updateList = snap.data['posts'];
    updateList.add(uploadRef.documentID);
    print(updateList);
    Firestore.instance.collection('users').document(user.uid).updateData({'posts': updateList});
    Navigator.pop(context, () {

    });
  }
}

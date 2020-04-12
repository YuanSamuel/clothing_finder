import 'package:clothingfinder/registerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clothingfinder/Home_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/entry.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key key, this.url}) : super(key: key);
  final String url;
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  get floatingActionButton => null;
  TextEditingController descriptionController;
  TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    descriptionController = new TextEditingController();
    titleController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Upload your Recycling'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Expanded(
            child: ListView(
                children: <Widget>[
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Give it a title",
                    ),
                    controller: titleController,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  new Container(
                      height: 300,
                      decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: new NetworkImage(
                                widget.url),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0),
                              bottomLeft: const Radius.circular(40.0),
                              bottomRight: const Radius.circular(40.0))),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Text(
                    'Describe your Accomplishment',
                    textAlign: TextAlign.center,
                  ),
                  new Container(
                    height: 300,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0),
                            bottomLeft: const Radius.circular(40.0),
                            bottomRight: const Radius.circular(40.0))),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "Quick description", border: InputBorder.none),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: descriptionController,
                    ),
                  ),
                ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEntry();
        },
        child: Icon(Icons.file_upload),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void addEntry() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot getUser = await Firestore.instance.collection('users').document(user.uid).get();
    entry newEntry = entry(
        name: titleController.text,
        userId: user.uid,
        url: widget.url,
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
    Navigator.pop(context);
  }
}

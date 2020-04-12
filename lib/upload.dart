import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://recycle-f9250.appspot.com");

  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_uploadTask != null){
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data.snapshot;

          double progressPercent = event != null ? event.bytesTransferred / event.totalByteCount : 0;

          return Column(
            children: <Widget>[
              if(_uploadTask.isComplete)
                Text('Complete'),

              LinearProgressIndicator(value: progressPercent,),
              Text('${(progressPercent *100).toStringAsFixed(2)} %'),
            ],
          );
        },
      );
    }
    else{
      return FlatButton.icon(
        label: Text('Upload to Firebase Cloud'),
        icon: Icon(Icons.file_upload),
        onPressed: _startUpload,
      );
    }
  }
}
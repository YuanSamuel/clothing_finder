import 'dart:io';

import 'package:clothingfinder/upload.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageFile() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image Picker Example'),
        ),
        body: Center(
          child: _image == null
              ? Text('No image selected.')
              : Image.file(_image),
        ),
        floatingActionButton: ListView(
          children: <Widget>[
            FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
            FloatingActionButton(
              onPressed: getImageFile,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_photo_alternate),
            ),
            if(_image != null) ...[
              
              Uploader(file: _image,)
            ]
          ],
          scrollDirection: Axis.vertical,
        )
    );
  }
}
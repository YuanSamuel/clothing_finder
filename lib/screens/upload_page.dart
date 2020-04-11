import 'package:clothingfinder/Home_Page.dart';
import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}
class _UploadPageState extends State<UploadPage> {
  get floatingActionButton => null;



@override
Widget build(BuildContext context) {

  return Scaffold(
      appBar: AppBar(
        title: const Text('Upload ur MasterPiece'),
      ),
      body: Container(
      decoration: BoxDecoration(
      color: Colors.white
  ),
         child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height/50,),
                new Container(
                  height: 300,
                  decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: new NetworkImage(
                            "https://images.squarespace-cdn.com/content/v1/5862e6e9bebafb318d9b5ed6/1483646784305-CF8XQZH8MPCUBBW6WP6L/ke17ZwdGBToddI8pDm48kNvT88LknE-K9M4pGNO0Iqd7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1USOFn4xF8vTWDNAUBm5ducQhX-V3oVjSmr829Rco4W2Uo49ZdOtO_QXox0_W7i2zEA/explore.jpg?format=2500w"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.only(
                          topLeft:  const  Radius.circular(40.0),
                          topRight: const  Radius.circular(40.0),
                          bottomLeft: const  Radius.circular(40.0),
                          bottomRight: const  Radius.circular(40.0))
                  ),
                    child: new Center(
                      child: new Text("Upload Image"),
                    )
                ),
                SizedBox(height: MediaQuery.of(context).size.height/40,),
      new Container(
          height: 300,
          decoration: new BoxDecoration(


              borderRadius: new BorderRadius.only(
                  topLeft:  const  Radius.circular(40.0),
                  topRight: const  Radius.circular(40.0),
                  bottomLeft: const  Radius.circular(40.0),
                  bottomRight: const  Radius.circular(40.0))
          ),
        child: TextFormField(
          decoration: InputDecoration(
              hintText:
              "quick description",
              border: InputBorder.none),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),

      ),

    ]


                ),
          floatingActionButton: FloatingActionButton.extended(
          onPressed: () {                    // Add your onPressed code here!
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => GalleryPage()
},
  label: Text('Save'),
  icon: Icon(Icons.file_upload),
  backgroundColor: Colors.blue,
  ),

      )


        );
  }
}
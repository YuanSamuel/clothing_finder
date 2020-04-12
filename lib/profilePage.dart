import 'package:flutter/material.dart';

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/BackgroundTwo.PNG'), fit: BoxFit.cover)
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 225),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 50),

                //Total Posts
                Text(
                  'Total Rushes',
                  style: TextStyle(
                      fontSize: 32,
                      fontStyle: FontStyle.italic,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Total Posts',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 50),
                //Total Stars
                Text(
                  'Stars Collected',
                  style: TextStyle(
                      fontSize: 32,
                      fontStyle: FontStyle.italic,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Total Stars Collected',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 50),
                RaisedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back_ios),
                  label: Text(
                    'Back'
                  ),
                )
              ],
            )
          ],
        ),
      ),
      );
  }
}

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          'Rating Page',
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic
          ),
        )
      ),
      backgroundColor: Colors.grey[900],
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(32, 32, 32, 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      const Radius.circular(40.0)
                    )
                  ),
                  height: 460,
                  width: 346,
                ),
              ),
              RatingBar(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 10,
                itemSize: 32,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(height: 6),
              ButtonTheme(
                minWidth: 200,
                height: 40,
                child: RaisedButton(
                  child: Text(
                    'Confirm Rating',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22
                    ),
                  ),
                  color: Colors.amber,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Post extends StatelessWidget {
  String name;
  String desc;
  String imgPath;
  Post(String _n, String _d, String _i){
    name = _n;
    desc = _d;
    imgPath = _i;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width-50,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Icon(Icons.person),
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            child: Text(
                              name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 5),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    desc,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width-70,
                height: 9*(MediaQuery.of(context).size.width-70)/16,
                child: Image.asset(imgPath),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: RatingBarIndicator(
                      rating: 5,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 30.0,
                    ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              )
          ),
        ),
      ],
    );
  }
}


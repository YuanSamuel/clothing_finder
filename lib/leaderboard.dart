
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {
  _space(int place, String name, int star) {
    return Row(
      children: [
        if (place == 1)
          Image.asset(
            'assets/1st.png',
            height: 25,
          ),
        if (place == 2)
          Image.asset(
            'assets/2nd.png',
            height: 25,
          ),
        if (place == 3)
          Image.asset(
            ''
                'assets/3rd.png',
            height: 25,
          ),
        if (place > 3)
          Text(
            place.toString(),
            style: TextStyle(fontSize: 25),
          ),
        Container(
          width: 12,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Row(
          children: [
            Image.asset(
              'assets/star.jpg',
              height: 25,
            ),
            Text(
              'x${star}',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            Container(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('users').getDocuments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: Center(
                child: Text('Loading'),
              ),
            );
          } else {
            List<DocumentSnapshot> docs = snapshot.data.documents;
            docs.sort((user1, user2) {
              return user2.data['points'].compareTo(user1.data['points']);
            });
            return Scaffold(
              body: ListView(
                children: [
                  Container(
                    height: 250,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/confetti.gif',
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              Column(children: [
                                Container(
                                  height: 150,
                                ),
                                Container(
                                  color: Colors.grey,
                                  width: 75,
                                  height: 100,
                                ),
                              ]),
                              Column(
                                children: [
                                  Container(
                                    height: 100,
                                  ),
                                  Container(
                                    color: Colors.yellow,
                                    width: 75,
                                    height: 150,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 200,
                                  ),
                                  Container(
                                    color: Colors.brown,
                                    width: 75,
                                    height: 50,
                                  ),
                                ],
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        for (int i = 0; i < min(docs.length, 10); i++)
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: _space(i + 1, docs[i].data['name'], docs[i].data['points'].round()),
                          ),
                      ],
                    ),
                  )
                ],
                scrollDirection: Axis.vertical,
              ),
            );
          }
        });
  }
}
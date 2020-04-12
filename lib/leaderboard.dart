import 'package:clothingfinder/models/entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {

  _space(entry passedEntry, int place) {
    return Row(
      children: [
        if(place==1)
          Image.asset(
            'assets/1st.png',
            height: 25,
          ),
        if(place==2)
          Image.asset(
            'assets/2nd.png',
            height: 25,
          ),
        if(place==3)
          Image.asset(''
            'assets/3rd.png',
            height: 25,
          ),
        if(place>3)
          Text(
            place.toString(),
            style: TextStyle(
              fontSize: 25
            ),
          ),
        Container(
          width: 12,
        ),
        Text(
          passedEntry.name,
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
              'x86',
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
                      Column(
                        children: [
                          Container(
                            height: 150,
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                ),
                                Text('Person2'),
                                Image.asset('assets/2nd.png', width: 20, height: 20,),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.grey,
                            width: 75,
                            height: 100,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 100,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                ),
                                Text('Person1'),
                                Image.asset('assets/1st.png', width: 20, height: 20,),
                              ],
                            ),
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
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                ),
                                Text('Person3'),
                                Image.asset('assets/3rd.png', width: 20, height: 20,),
                              ],
                            ),
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
            child: FutureBuilder(
              future: Firestore.instance.collection('users').getDocuments(),
              builder: (context, snapshot) {
                if(snapshot.connectionState != ConnectionState.done) {
                  return Text('Loading...');
                }
                else{

                  List<DocumentSnapshot> mostPoints = snapshot.data.documents;
                  mostPoints.sort((a, b) {
                    return (a.data['points']).floor();
                  });

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, int i) {
                        return Row(children: <Widget>[
                          _space(entry.fromJson(mostPoints[i].data), i),
                          SizedBox(
                            width: 10,
                          )
                        ],);
                      });
                }
              },
            ),
          )
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

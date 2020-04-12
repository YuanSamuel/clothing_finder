import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {

  _space(int place, String name, int star) {
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
                for(int i=1;i<11;i++)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: _space(i, 'Person${i}', 10),
                  ),
              ],
            ),
          )
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

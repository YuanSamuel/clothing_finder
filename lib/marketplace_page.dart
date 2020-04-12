import 'package:flutter/material.dart';

class MarketplacePage extends StatefulWidget {
  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 20,
        ),
        Text('Marketplace', style: TextStyle(
          fontSize: 25
        ),textAlign: TextAlign.center,),
      GridView.count(
        shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              Text('Arduino Gift Card'),
              Image.asset('assets/ArduinoCommunityLogo.png', width: MediaQuery.of(context).size.width / 4,),
              Text('50 points')
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              Text('Arduino Gift Card'),
              Image.asset('assets/ArduinoCommunityLogo.png', width: MediaQuery.of(context).size.width / 4,),
              Text('50 points')
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              Text('Arduino Gift Card'),
              Image.asset('assets/ArduinoCommunityLogo.png', width: MediaQuery.of(context).size.width / 4,),
              Text('50 points')
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              Text('Arduino Gift Card'),
              Image.asset('assets/ArduinoCommunityLogo.png', width: MediaQuery.of(context).size.width / 4,),
              Text('50 points')
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              Text('Arduino Gift Card'),
              Image.asset('assets/ArduinoCommunityLogo.png', width: MediaQuery.of(context).size.width / 4,),
              Text('50 points')
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              Text('Arduino Gift Card'),
              Image.asset('assets/ArduinoCommunityLogo.png', width: MediaQuery.of(context).size.width / 4,),
              Text('50 points')
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              Text('Arduino Gift Card'),
              Image.asset('assets/ArduinoCommunityLogo.png', width: MediaQuery.of(context).size.width / 4,),
              Text('50 points')
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              Text('Arduino Gift Card'),
              Image.asset('assets/ArduinoCommunityLogo.png', width: MediaQuery.of(context).size.width / 4,),
              Text('50 points')
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              Text('Arduino Gift Card'),
              Image.asset('assets/ArduinoCommunityLogo.png', width: MediaQuery.of(context).size.width / 4,),
              Text('50 points')
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              Text('Arduino Gift Card'),
              Image.asset('assets/ArduinoCommunityLogo.png', width: MediaQuery.of(context).size.width / 4,),
              Text('50 points')
            ],
          ),
        ),
      ],
    ),
      ],
    );
  }
}
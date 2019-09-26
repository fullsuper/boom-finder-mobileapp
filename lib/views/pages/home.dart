import 'package:boom_finder_dev/views/widgets/alert/confirmAlert.dart';
import 'package:boom_finder_dev/views/widgets/button/circle_button_text.dart';
import 'package:boom_finder_dev/views/widgets/card/verticalCard.dart';
import 'package:flutter/material.dart';
import './../layouts/_layout.dart';

import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Container(

        child: ListView(
          children: <Widget>[
            CarouselSlider(
              height: 250,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              autoPlayInterval: Duration(seconds: 5),
              items: [1, 2].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: (i % 2 == 0)
                              ? NetworkImage(
                                  'https://www.homeinnreginaairport.ca/Content/images/room_slider.jpg'
                                )
                              : NetworkImage(
                                  'https://images.unsplash.com/photo-1562184552-997c461abbe6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                                ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Container(
              //padding: new EdgeInsets.only(top: 10.0),
              //height: 150.0,
              margin: new EdgeInsets.all(10.0),
              decoration: new BoxDecoration(
                //border: Border.all(width: 2.0, color: const Color(0xcccccccc)),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                backgroundBlendMode: BlendMode.color(0xfffffff)
                /*boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 4.0, // has the effect of softening the shadow
                    spreadRadius: 3.0, // has the effect of extending the shadow
                  )
                ],*/
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {},
                        child: new Icon(
                          Icons.pause,
                          color: Colors.blue,
                          size: 35.0,
                        ),
                        shape: CircleBorder(),
                        elevation: 2.0,
                        fillColor: Colors.white,
                        padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
                        child: Text(
                          'Hello World',
                        ),
                      ),
                    ],
                  ),
                  CircleIconButtonText('hello world', Icons.plus_one, null),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {},
                        child: Image.network(
                            "https://www.flaticon.com/premium-icon/icons/svg/1531/1531776.svg",
                            width: 40,
                            fit: BoxFit.fill),
                        shape: CircleBorder(),
                        elevation: 2.0,
                        fillColor: Colors.blueAccent,
                        padding: const EdgeInsets.all(15.0),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Hello World',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CarouselSlider(
              aspectRatio: 16/9,
              enableInfiniteScroll: true,
              autoPlay: false,
              viewportFraction: 1.0,
              autoPlayInterval: Duration(seconds: 5),
              height: 300,
              items: [1, 2].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return VerticalCard(
                        imageSrc: 'hello',
                        description: 'hello hello everyone  everyone ',
                        onClick: ()=>{},title: 'hello'
                    );
                  },
                );
              }).toList(),
            ),

          ],
        ),
      ),
    );

    return Layout(mainContent);
  }
}

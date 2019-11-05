import 'dart:io';

import 'package:badges/badges.dart';
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
        /* decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xffa1c4fd), Color(0xffc2e9fb)],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0.0, 1.1],
              tileMode: TileMode.clamp),
        ),*/
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.home, size: 35.0),
                  Text(
                    ' Boom Finder ',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Badge(
                      badgeColor: Colors.green,
                      shape: BadgeShape.square,
                      borderRadius: 5,
                      badgeContent: Text(' beta ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900)),
                    ),
                  ),
                ],
              ),
            ),







            Container(
              decoration: BoxDecoration(color: Colors.white70),
              child: CarouselSlider(
                height: 120,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.45,
                autoPlayInterval: Duration(seconds: 5),
                items: [1, 2].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: (i % 2 == 0)
                                ? NetworkImage(
                                'https://www.royalplaza.com.sg/wp-content/uploads/sites/46/2016/09/4-Royal-Club-Premier-Room-in-Sunflower-Yellow-Royal-Plaza-on-Scotts.jpg')
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
            ),



            /*ListView(
              scrollDirection: Axis.vertical,
              children:
                List.generate(6, (index) =>
                  FlatButton(

                    color: Colors.black,
                    child: Text('hello '),
                  )
                ),
            ),*/




            Container(
              //padding: new EdgeInsets.only(top: 10.0),
              //height: 150.0,
              margin: new EdgeInsets.all(10.0),
              decoration: new BoxDecoration(
                //border: Border.all(width: 2.0, color: const Color(0xcccccccc)),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
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


            Row(
              children:<Widget>[

                Expanded(

                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: List.generate(6, (index) {
                      return GestureDetector(
                        onTap: () => {},
                        child:

                        Container(
                          width:  MediaQuery.of(context).size.width/3 - 10,
                          margin: EdgeInsets.all(3.0),
                          padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.topLeft,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image(
                                image: NetworkImage('https://d2ile4x3f22snf.cloudfront.net/wp-content/uploads/sites/282/2018/04/23070030/Room-1.jpg'),
                              ),
                              Text(
                                'hello world ',
                                style: TextStyle(color: Colors.black, fontSize: 16.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('what'),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text('5'),
                                        Icon(Icons.star, size: 6.0,)
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),




            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Newest Rooms',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'montserrat'),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context, "myRoute");
                    },
                    child: Text(
                      "see All",
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            CarouselSlider(
              aspectRatio: 16 / 9,
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
                        onClick: () => {},
                        title: 'hello');
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Badge(
                          badgeColor: Colors.redAccent,
                          shape: BadgeShape.square,
                          borderRadius: 20,
                          toAnimate: false,
                          badgeContent: Text(
                            ' hot! ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Text(
                          ' Another search',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'montserrat'),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context, "myRoute");
                    },
                    child: Text(
                      "see All",
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            CarouselSlider(
              aspectRatio: 16 / 9,
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
                        onClick: () => {},
                        title: 'hello');
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

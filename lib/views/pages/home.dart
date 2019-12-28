import 'package:badges/badges.dart';
import 'package:boom_finder_dev/views/widgets/button/circle_button_text.dart';
import 'package:boom_finder_dev/views/widgets/item/verticalCard.dart';
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
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    Colors.greenAccent,
                    Colors.orangeAccent,
                    Colors.redAccent
                  ])),
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 7),
                    child: Icon(
                      Icons.location_city,
                      size: 35.0,
                      color: Colors.amber[400],
                    ),
                  ),
                  Text(
                    ' Boom Finder  ',
                    style: TextStyle(
                      fontSize: 35.0,
                      wordSpacing: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      color: Colors.lightBlueAccent[200],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7.0),
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
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                autoPlayInterval: Duration(seconds: 5),
                items: [1, 2].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: (i % 2 == 0)
                                ? NetworkImage(
                                    'https://q-cf.bstatic.com/images/hotel/max1024x768/134/134203664.jpg')
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
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.fromLTRB(0,30,0,50),
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  color: Colors.white
                  ),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  CircleIconButtonText(
                      'All',
                      Icon(
                        Icons.view_array,
                        color: Colors.amber[400],
                        size: 30,
                      ),
                      () => Navigator.pushNamed(context, '/list_room')),
                  CircleIconButtonText(
                      'New',
                      Icon(
                        Icons.add_location,
                        color: Colors.purple,
                        size: 30,
                      ),
                      () => Navigator.pushNamed(context, '/add_room')),
                  CircleIconButtonText(
                      'Compare',
                      Icon(
                        Icons.compare,
                        color: Colors.green,
                        size: 30,
                      ),
                      () => Navigator.pushNamed(context, '/compare_list')),
                  CircleIconButtonText(
                      'Search',
                      Icon(
                        Icons.find_replace,
                        color: Colors.redAccent,
                        size: 30,
                      ),
                      () => Navigator.pushNamed(context, '/search_room')),
                ],
              ),
            ),
            Container(

              padding: EdgeInsets.only(bottom: 20),
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                'People also viewed',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: <Color>[Colors.blueAccent, Colors.greenAccent],
                      ).createShader(Rect.fromLTWH(40.0, 5.0, 250.0, 4.0)),
                    decorationThickness: 2
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))
              ),              alignment: Alignment.center,
              child: Wrap(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3 - 10,
                      margin: EdgeInsets.all(3.0),
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),

                        gradient: LinearGradient(
                            colors: <Color>[Colors.grey, Colors.blueGrey, Colors.blueAccent],
                            stops: [0.6, 0.8, 1],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          )
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image(
                            image: NetworkImage(
                                'https://d2ile4x3f22snf.cloudfront.net/wp-content/uploads/sites/282/2018/04/23070030/Room-1.jpg'),
                            width: 170,
                            height: 85,
                          ),
                          Text(
                            'Room ' + (index + 1).toString(),
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: <Widget>[
                                Text('Rating: '),
                                Text('5 '),
                                Icon(
                                  Icons.star,
                                  size: 15.0,
                                  color: Colors.deepOrange,
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text('View count: '),
                                Text('5 '),
                                Icon(
                                  Icons.remove_red_eye,
                                  size: 15.0,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            Container(

              decoration: BoxDecoration(),
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Badge(
                    badgeContent: Text(
                      'Newest Rooms',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'montserrat',
                          color: Colors.white),
                    ),
                    shape: BadgeShape.square,
                    borderRadius: 10,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    badgeColor: Colors.blue,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/list_room");
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_right, color: Colors.white),
                            Text(
                              "See All",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            CarouselSlider(

              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              autoPlay: false,
              viewportFraction: 1.0,
              autoPlayInterval: Duration(seconds: 5),
              height: 400,
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
            Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Badge(
                            badgeContent: Text(
                              'Popular',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'montserrat',
                                  color: Colors.white70),
                            ),
                            shape: BadgeShape.square,
                            borderRadius: 10,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            badgeColor: Colors.blue,
                          ),
                        ),
                        Badge(
                            padding: EdgeInsets.all(10),
                            badgeColor: Colors.redAccent,
                            shape: BadgeShape.square,
                            borderRadius: 20,
                            toAnimate: false,
                            badgeContent: Text(
                              ' hot ',
                              style: TextStyle(fontSize: 18),
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/list_room");
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_right, color: Colors.white),
                            Text(
                              "See All",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            CarouselSlider(
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              autoPlay: false,
              viewportFraction: 1.0,
              autoPlayInterval: Duration(seconds: 5),
              height: 400,
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

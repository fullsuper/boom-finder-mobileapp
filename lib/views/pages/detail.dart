import 'dart:io';

import 'package:badges/badges.dart';
import 'package:boom_finder_dev/views/widgets/alert/confirmAlert.dart';
import 'package:boom_finder_dev/views/widgets/button/circle_button_text.dart';
import 'package:boom_finder_dev/views/widgets/card/verticalCard.dart';
import 'package:flutter/material.dart';
import './../layouts/_layout.dart';

import 'package:carousel_slider/carousel_slider.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Container(
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Image(
                fit: BoxFit.fitWidth,
                height: 200,
                width: MediaQuery.of(context).size.width,
                image: NetworkImage(
                    'https://2486634c787a971a3554-d983ce57e4c84901daded0f67d5a004f.ssl.cf1.rackcdn.com/indian-springs-calistoga/media/indiansprings-header-theviewrooms-5c4ba99cb73c7.jpg'),
              ),
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  10,
                  (i) => Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Image(
                      fit: BoxFit.fitHeight,
                      height: 90,
                      width: 70,
                      image: NetworkImage(
                          'https://2486634c787a971a3554-d983ce57e4c84901daded0f67d5a004f.ssl.cf1.rackcdn.com/indian-springs-calistoga/media/indiansprings-header-theviewrooms-5c4ba99cb73c7.jpg'),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Badge(
                    badgeColor: Colors.green,
                    shape: BadgeShape.square,
                    borderRadius: 5,
                    badgeContent: Text(' new ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w900)),
                  ),
                ),
                Text(
                  'Rooms test',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.people),
                        Text(' Mr.Dong'),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          '0168.504.1129',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Icon(
                          Icons.phone_android,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged"),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.green,
              alignment: Alignment.center,
              height: 300,
              padding: EdgeInsets.all(10),
              child: Text("Map here"),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image(
                      image: NetworkImage(
                          'https://d12swbtw719y4s.cloudfront.net/images/c3jRZQtA/lOHfuGybE2DtFw8RGTW8/nannot.jpeg?w=620'),
                      fit: BoxFit.cover,
                      height: 70,
                    ),
                  ),
                  Flexible(

                    child:
                      Text(

                        'hllo hllohllohllohlloh llohllohllohllohllohllohlllohllohllohllohllohllohlllohllohllohllohllohllohl lohllohllohllohllohllohllohllohllohllohlloh llohllohllohllohllohllohllo',
                        overflow: TextOverflow.ellipsis,textAlign: TextAlign.left,

                        maxLines: 2,
                      ),

                  )

                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image(
                      image: NetworkImage(
                          'https://d12swbtw719y4s.cloudfront.net/images/c3jRZQtA/lOHfuGybE2DtFw8RGTW8/nannot.jpeg?w=620'),
                      fit: BoxFit.cover,
                      height: 70,
                    ),
                  ),
                  Container(
                    width: 50,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter a search term'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

    return Layout(mainContent);
  }
}

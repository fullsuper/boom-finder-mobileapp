import 'dart:io';

import 'package:badges/badges.dart';
import 'package:boom_finder_dev/views/widgets/alert/confirmAlert.dart';
import 'package:boom_finder_dev/views/widgets/button/circle_button_text.dart';
import 'package:boom_finder_dev/views/widgets/card/verticalCard.dart';
import 'package:flutter/material.dart';
import './../layouts/_layout.dart';

import 'package:carousel_slider/carousel_slider.dart';

class RoomsPage extends StatefulWidget {
  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 5),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.sort), iconSize: 35,),
                  IconButton(icon: Icon(Icons.tune), iconSize: 35,),
                ],
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: List.generate(
                  12,
                  (i) =>
                  Container(

                        margin: EdgeInsets.all(3.0) ,
                        padding: EdgeInsets.all(5.0),
                        width: MediaQuery.of(context).size.width / 2 - 10,

                          color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image(
                              fit: BoxFit.fill,
                                image: NetworkImage(
                                    'https://2486634c787a971a3554-d983ce57e4c84901daded0f67d5a004f.ssl.cf1.rackcdn.com/indian-springs-calistoga/media/indiansprings-header-theviewrooms-5c4ba99cb73c7.jpg'
                                ),
                            ),
                            Text('Room Name', style: TextStyle(fontSize: 20), ),
                            Container(
                              height: 35,
                              child: Text('RoomRoomRoomRoomRoomRoom gjym Namez', ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.people),
                                    Text('Mr.Dong'),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.phone,
                                    ),
                                    Text('0817261728'),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.remove_red_eye),
                                    Text('40'),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('5'),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                  /*    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                        color: Colors.white,
                        height: 130,
                        child: Row(
                          children: <Widget>[
                            Image(
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://2486634c787a971a3554-d983ce57e4c84901daded0f67d5a004f.ssl.cf1.rackcdn.com/indian-springs-calistoga/media/indiansprings-header-theviewrooms-5c4ba99cb73c7.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Room Name', style: TextStyle(fontSize: 20),),
                                    Text(
                                      'Address',
                                      maxLines: 2,
                                    ),
                                    Text(
                                      'Address',
                                      maxLines: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 120,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.people),
                                              Text('Mr. Dong')
                                            ],
                                          ),
                                        ),
                                        Container(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(Icons.people),
                                                Text('Mr. Dong')
                                              ],
                                            ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 120,
                                          child:  Row(
                                            children: <Widget>[
                                              Icon(Icons.remove_red_eye),
                                              Text('40'),
                                            ],

                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text('5'),
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                            ],
                                          ),
                                        ),


                                      ],
                                    ),

                                  ]),
                            ),
                          ],
                        ),
                      ),*/
                  )
            ),
          ],
        ),
      ),

    );

    return Layout(mainContent);
  }
}

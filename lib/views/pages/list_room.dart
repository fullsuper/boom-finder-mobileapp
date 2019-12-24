import 'package:boom_finder_dev/views/widgets/streamBuilderWidget/RoomStreamList.dart';
import 'package:flutter/material.dart';
import './../layouts/_layout.dart';

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
                  IconButton(icon: Icon(Icons.sort), iconSize: 35, onPressed: (){}),
                  IconButton(icon: Icon(Icons.tune), iconSize: 35, onPressed: (){}),
                ],
              ),
            ),
            RoomStreamList(),
          ],
        ),
      ),

    );

    return Layout(mainContent);
  }
}

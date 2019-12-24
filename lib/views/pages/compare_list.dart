import 'dart:async';
import 'package:badges/badges.dart';
import 'package:boom_finder_dev/models/room.dart';
import 'package:boom_finder_dev/views/pages/compare_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './../layouts/_layout.dart';

final databaseReference = Firestore.instance;

class CompareListRoom extends StatefulWidget {
  List<Room> rooms = List<Room>();
  List<Room> roomsToCompare = List<Room>();

  @override
  _CompareListRoomState createState() => _CompareListRoomState();
}

class _CompareListRoomState extends State<CompareListRoom> {
  Border choosenBorder = Border.all(width: 5, color: Colors.lightBlue,style: BorderStyle.solid);

  Future _getListRoom() async {
    List<Room> rooms = List();

    await Firestore.instance
        .collection('Room')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((data) {
        rooms.add(Room.fromSnapshot(data));
      });
      //print("DATA LENGTH " + snapshot.documents.length.toString());
    });

    return rooms;
  }

  CompareListRoom(){
    _getListRoom().then((value) {
      setState(() {
        widget.rooms = value;
      });
    });
  }

  @override
  void initState() {
    _getListRoom().then((value) {
      setState(() {
        widget.rooms = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
        child: ListView(
      children: widget.rooms
          .map((room) => GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.roomsToCompare.contains(room)) {
                      widget.roomsToCompare.remove(room);
                    } else {
                      widget.roomsToCompare.add(room);
                    }
                  });
                  
                  if(widget.roomsToCompare.length == 2){
                    Navigator.pushNamed(
                        context,
                        CompareDetail.routeName,
                        arguments: [widget.roomsToCompare[0], widget.roomsToCompare[1]]
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: widget.roomsToCompare.contains(room) ? Colors.grey : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    border:  widget.roomsToCompare.contains(room)
                        ? choosenBorder
                        : Border.all(width: 5, color: Colors.white)
                  ),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(15.0),
                        child: Image(
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                            image: NetworkImage(room.image.toString())),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                room.title.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                room.name.toString(),
                                maxLines: 2,
                              ),
                              Text(
                                room.description.length > 35
                                    ? room.description.substring(0, 32) + '...'
                                    : room.description,
                                maxLines: 2,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        Icon(Icons.phone),
                                        Text('038 504 1129')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.remove_red_eye),
                                        Text(room.view.toString()),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(room.like.toString()),
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
                ),
              ))
          .toList(),
    ));

    return Layout(mainContent);
  }
}

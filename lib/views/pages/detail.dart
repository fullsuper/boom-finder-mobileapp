import 'dart:async';

import 'package:badges/badges.dart';
import 'package:boom_finder_dev/models/room.dart';
import 'package:boom_finder_dev/views/widgets/item/comment_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './../layouts/_layout.dart';

final databaseReference = Firestore.instance;

class DetailPage extends StatefulWidget {
  static const String routeName = '/detail_room';
  final Room room;

  DetailPage({@required this.room});

  @override
  _DetailPageState createState() => _DetailPageState();
}

Completer<GoogleMapController> _controller = Completer();

class _DetailPageState extends State<DetailPage> {
  List<Marker> allMarkers = [];
  TextEditingController _commentController = TextEditingController();
  bool _isLike = false, _isComment = false;

  @override
  void initState() {
    super.initState();
    countUpView();
    allMarkers.add(Marker(
        markerId: MarkerId('currentRoomLocation'),
        draggable: false,
        position: LatLng(
            widget.room.location.latitude, widget.room.location.longitude),
        infoWindow: InfoWindow(
            title: widget.room.title.toString(),
            snippet: widget.room.description.toString())));
    print(widget.room);
  }

  Future<void> countUpView() async {
    setState(() {
      widget.room.countUpView();
    });

    await Firestore.instance
        .collection('Room')
        .document(widget.room.documentId)
        .updateData(widget.room.toJson());
  }


  Future<void> likeRoom() async {
    if (!_isLike) {
      setState(() {
        widget.room.countUpLike();

      });

      await Firestore.instance
          .collection('Room')
          .document(widget.room.documentId)
          .updateData(widget.room.toJson());

      _isLike = true;
    }
  }

  Future<void> addComment() async {
    String comment = _commentController.text;
    if (comment.isEmpty || _isComment) {
      return;
    }

    setState(() {
      widget.room.addComment(comment);
    });

    await Firestore.instance
        .collection('Room')
        .document(widget.room.documentId)
        .updateData(widget.room.toJson());
  }

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
                height: 300,
                width: MediaQuery.of(context).size.width,
                image: NetworkImage(widget.room.image),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              margin: EdgeInsets.only(top: 30, left: 10, right: 10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      // Colors are easy thanks to Flutter's Colors class.
                      Colors.indigo[900],
                      Colors.indigo[700],
                      Colors.indigo[600],
                      Colors.indigo[400],
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: <Widget>[
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ),
                      Text(
                        'Rooms test',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.people,
                                color: Colors.brown,
                                size: 40,
                              ),
                              Text(
                                ' Admin',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.amberAccent[100],
                                    Colors.amberAccent[400],
                                    Colors.amberAccent[700]
                                  ],
                                  stops: [
                                    0.1,
                                    0.8,
                                    1
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: Colors.green,
                                size: 30,
                              ),
                              Text(
                                ' 038 504 1129',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 22),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' + Description:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          shadows: [
                            Shadow(
                                blurRadius: 10,
                                offset: Offset.infinite,
                                color: Colors.black)
                          ],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget.room.description,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Room Location',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w700,
                          fontSize: 25),
                    ),
                    Icon(
                      Icons.home,
                      color: Colors.blueAccent,
                      size: 35,
                    )
                  ],
                )),
            Container(
              height: 400,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.room.location.latitude,
                      widget.room.location.longitude),
                  zoom: 14.4746,
                ),
                markers: Set.from(allMarkers),
                onMapCreated: (GoogleMapController controller) {
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))
              ),
              child: Text(
                'Who see this?',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  color: Colors.indigo
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.remove_red_eye,
                          color: Colors.indigo,
                          size: 30,
                        ),
                        Text(
                          ' ' + widget.room.view.toString(),
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed:  likeRoom,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.amber,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                        Text(
                          ' ' + widget.room.like.toString(),
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.4),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Comments ',
                      style: TextStyle(
                          color: Colors.yellow.withOpacity(0.8),
                          fontWeight: FontWeight.w700,
                          fontSize: 25),
                    ),
                    Icon(
                      Icons.chat,
                      color: Colors.yellowAccent,
                      size: 35,
                    )
                  ],
                )),
            widget.room.comments != null && widget.room.comments.length > 0
                ? Container(
                    padding: EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(color: Colors.blue.withOpacity(0.3)),
                    child: Column(
                        children: widget.room.comments
                            .map((dynamic cmt) => CommentItem(
                                  comment: cmt['comment'],
                                  time: cmt['date'],
                                ))
                            .toList()),
                  )
                : Container(
                    alignment: Alignment.center,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.3),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'No comment to see. Be the first person comment on this room',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              constraints: BoxConstraints(minHeight: 100),
              decoration: BoxDecoration(color: Colors.blue.withOpacity(0.3)),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Your Comments',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(10),

                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: TextFormField(

                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Your comment',
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none
                      ),
                      minLines: 3,
                      maxLines: 3,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: addComment,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            children: <Widget>[Text('Send  ', style: TextStyle(
                              fontSize: 18
                            ),), Icon(Icons.send, color: Colors.indigo,)],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Layout(mainContent);
  }
}

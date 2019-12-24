import 'dart:async';

import 'package:badges/badges.dart';
import 'package:boom_finder_dev/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './../layouts/_layout.dart';

final databaseReference = Firestore.instance;

class DetailPage extends StatefulWidget {
  static const String routeName = '/detail_room';
  final Room room;

  DetailPage({Key key, @required this.room}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

Completer<GoogleMapController> _controller = Completer();

class _DetailPageState extends State<DetailPage> {
  List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
      markerId: MarkerId('currentRoomLocation'),
      draggable: false,
      position: LatLng(widget.room.location.latitude, widget.room.location.longitude),
    ));
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
                height: 200,
                width: MediaQuery.of(context).size.width,
                image: NetworkImage(widget.room.image),
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
                        Text(' ' + widget.room.owner.toString()),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'hardcode',
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
                widget.room.description,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Container(
              height: 300,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.room.location.latitude, widget.room.location.longitude),
                  zoom: 14.4746,
                ),
                markers: Set.from(allMarkers),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
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
                  Flexible(
                    child: Text(
                      'hllo hllohllohllohlloh llohllohllohllohllohllohlllohllohllohllohllohllohlllohllohllohllohllohllohl lohllohllohllohllohllohllohllohllohllohlloh llohllohllohllohllohllohllo',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
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

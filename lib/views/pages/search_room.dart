import 'dart:async';

import 'package:boom_finder_dev/models/room.dart';
import 'package:boom_finder_dev/views/utils/LocationUtils.dart';
import 'package:boom_finder_dev/views/widgets/appbar/bottom_bar_redesign.dart';
import 'package:boom_finder_dev/views/widgets/appbar/top_bar.dart';
import 'package:boom_finder_dev/views/widgets/textField/FilledBorderTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'detail.dart';

class SearchRoomPage extends StatefulWidget {
  List<Marker> allMarker = List();
  List<Room> allRooms = List();

  @override
  _SearchRoomPageState createState() => _SearchRoomPageState();
}

class _SearchRoomPageState extends State<SearchRoomPage> {
  Completer<GoogleMapController> _mapController = Completer();
  TextEditingController searchingAddrees = TextEditingController();
  LatLng myLocation = LatLng(0, 0);

  Future _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    return currentLocation;
  }

  Future<void> _moveToPosition(Position pos) async {
    final GoogleMapController mapController = await this._mapController.future;
    if (mapController == null) return;

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude, pos.longitude),
      zoom: 20.0,
      bearing: 192.8334901395799,
    )));
  }

  Future<void> _getAllMarkers() async {
    List<Room> rooms = List();

    await Firestore.instance
        .collection('Room')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((data) {
        Room room = Room.fromSnapshot(data);
        print('Have' + room.name);

        rooms.add(Room.fromSnapshot(data));
        widget.allMarker.add(Marker(
          markerId: MarkerId(room.name),
          infoWindow: InfoWindow(title: room.title),
          position: LatLng(room.location.latitude, room.location.longitude),
          draggable: false,
          onTap: () {
            Navigator.pushNamed(context, DetailPage.routeName, arguments: room);
          },
        ));
      });
    });

    setState(() {
      widget.allRooms = rooms;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: GoogleMap(
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        rotateGesturesEnabled: true,
        mapToolbarEnabled: true,
        tiltGesturesEnabled: true,
        scrollGesturesEnabled: true,
        onLongPress: (LatLng location) async {
          final GoogleMapController mapController =
              await this._mapController.future;
          if (mapController == null) return;

          mapController
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: location,
            zoom: 10.0,
            bearing: 192.8334901395799,
          )));
        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: myLocation,
          zoom: 20,
        ),
        onMapCreated: (GoogleMapController controller) async {
          await _getAllMarkers();
          this._mapController.complete(controller);
          var location = await _getLocation();

          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(location.latitude, location.longitude),
                zoom: 20),
          ));
          setState(() {
            widget.allMarker.add(Marker(
              markerId: MarkerId("curr_loc"),
              position: LatLng(location.latitude, location.longitude),
              infoWindow: InfoWindow(title: 'Your are here'),
              draggable: false,
            ));
          });
        },
        markers: widget.allMarker.toSet(),
      ),
    );

    return Scaffold(
      appBar: TopBar(
        title: 'Room Finder',
      ),
      body: mainContent,
      bottomNavigationBar: BottomBar(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  width: 900,
                  alignment: Alignment.center,
                  height: 250,
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Location want to find room?',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ),
                        alignment: Alignment.center,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: 200,
                            height: 50,
                            child: TextFormField(
                              controller: searchingAddrees,
                              style: TextStyle(fontSize: 20),
                              strutStyle: StrutStyle(fontSize: 20),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_on),
                                hintText: 'Location',
                                hintStyle: TextStyle(fontSize: 25),
                                contentPadding: EdgeInsets.only(bottom: 10),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                          IconButton(

                            icon: Icon(Icons.search),
                            padding: EdgeInsets.only(top: 20),
                            color: Colors.black,
                            focusColor: Colors.indigo,
                            alignment: Alignment.center,
                            hoverColor: Colors.deepOrange,
                            iconSize: 40,
                            splashColor: Colors.amber,
                            onPressed: () async {
                              Position searchPosition =
                                  await LocationUtils.getLocationByAddress(
                                      searchingAddrees.text);
                              _moveToPosition(searchPosition);
                              Navigator.pop(context);
                            },
                            highlightColor: Colors.green,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(


                              child: Text(
                                'Close'
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              color: Colors.blue,

                              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}

import 'dart:async';

import 'package:badges/badges.dart';
import 'package:boom_finder_dev/models/room.dart';
import 'package:boom_finder_dev/views/utils/DialogUtils.dart';
import 'package:boom_finder_dev/views/utils/DistanceBetween.dart';
import 'package:boom_finder_dev/views/utils/LocationUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './../layouts/_layout.dart';

class CompareDetail extends StatefulWidget {
  static const String routeName = '/compare_detail';

  Room firstRoom, secondRoom;

  CompareDetail({this.firstRoom, this.secondRoom});

  @override
  _CompareDetailState createState() => _CompareDetailState();
}

class _CompareDetailState extends State<CompareDetail> {
  int firstDistance = 0, secondDistance = 0;
  Completer<GoogleMapController> _mapController = Completer();
  Map<String, Marker> markers = Map<String, Marker>();

  TextEditingController distanceCompareController = TextEditingController();

  TextStyle normalTextStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'montserrat');

  Future<void> _measureDistance() async {
    String address = distanceCompareController.text;
    //print(address);
    if(address == null || address.isEmpty){
      showWarningAlert(context: context, title: 'Missing address', description: 'Should Enter Address!');
      return;
    }
    Position pos = await LocationUtils.getLocationByAddress(address);

    print(pos.longitude.toString());
    setState(() {
      firstDistance = getDistanceBetween(
              GeoPoint(pos.latitude, pos.longitude), widget.firstRoom.location,
              method: 2)
          .round();
      secondDistance = getDistanceBetween(
              GeoPoint(pos.latitude, pos.longitude), widget.secondRoom.location)
          .round();
      markers['Wanted Location'] = Marker(
          markerId: MarkerId('Wanted Location'),
          position: LatLng(pos.latitude, pos.longitude),
          infoWindow: InfoWindow(title: 'Wanted Location', snippet: address));
    });
  }

  @override
  void initState() {
/*    print( 'hello' +widget.firstRoom.toString());
    print(widget.secondRoom.toString());*/

    markers[widget.firstRoom.name] = Marker(
        markerId: MarkerId(widget.firstRoom.name),
        position: LatLng(widget.firstRoom.location.latitude,
            widget.firstRoom.location.longitude),
        infoWindow: InfoWindow(title: widget.firstRoom.title));

    markers[widget.secondRoom.name] = Marker(
      markerId: MarkerId(widget.secondRoom.name),
      position: LatLng(widget.secondRoom.location.latitude,
          widget.secondRoom.location.longitude),
      infoWindow: InfoWindow(title: widget.secondRoom.title),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: <Widget>[
            Container(
              height: 20,

              decoration: BoxDecoration(
                  color: Colors.indigo,

                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),

            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Badge(
                padding: EdgeInsets.all(10),
                badgeColor: Colors.greenAccent,
                shape: BadgeShape.square,
                borderRadius: 10,
                badgeContent: Text(
                  ' Room ',
                  style: normalTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.43,
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.firstRoom.name.toString(),
                      style: normalTextStyle,
                    ),
                  ),
                  Container(
                    height: 50,
                    child: VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.43,
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.secondRoom.name.toString(),
                      style: normalTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Badge(
                padding: EdgeInsets.all(10),
                badgeColor: Color(0xFF230444),
                shape: BadgeShape.square,
                borderRadius: 10,
                badgeContent: Text(
                  ' Distance ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'montserrat'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Text('Where do you want to go?',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 1.2,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.63,
                    child: TextFormField(
                      controller: this.distanceCompareController,
                      focusNode: FocusNode(),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        hintText: 'Location want to go',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        alignLabelWithHint: true,
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: RaisedButton(
                      color: Colors.indigo,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                      child: Icon(
                        Icons.map,
                        size: 30,
                      ),
                      onPressed: () => _measureDistance(),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        (widget.firstRoom.location.latitude +
                                widget.secondRoom.location.latitude) *
                            0.5,
                        (widget.firstRoom.location.longitude +
                                widget.secondRoom.location.longitude) *
                            0.5),
                    zoom: 13,
                    bearing: 10),
                markers: markers.values.toSet(),
                onMapCreated: (GoogleMapController controller) {
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      onPressed: () async{
                        final GoogleMapController mapController = await this._mapController.future;
                        LocationUtils.moveToPosition(widget.firstRoom.location, mapController);
                      },
                      padding: EdgeInsets.all(10),
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Text('Locate'),
                          Icon(
                            Icons.location_on,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                      focusColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                  MaterialButton(
                      onPressed: () async{
                        String address = distanceCompareController.text;
                        //print(address);
                        if(address == null || address.isEmpty){
                          showWarningAlert(context: context, title: 'Missing address', description: 'Should Enter Address!');
                          return;
                        }
                        Position pos = await LocationUtils.getLocationByAddress(address);
                        final GoogleMapController mapController = await this._mapController.future;
                        LocationUtils.moveToPosition(GeoPoint(pos.latitude, pos.longitude), mapController);
                      },
                      minWidth: 40,
                      color: Colors.green,
                      padding: EdgeInsets.all(10),
                      height: 50,
                      child: Text('Wanted Location'),
                      focusColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                  MaterialButton(
                      onPressed: () async{
                        final GoogleMapController mapController = await this._mapController.future;
                        LocationUtils.moveToPosition(widget.secondRoom.location, mapController);
                      },
                      padding: EdgeInsets.all(10),
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.redAccent,
                          ),
                          Text('Room 2'),
                        ],
                      ),
                      focusColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        shape: BoxShape.rectangle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.swap_calls,
                          size: 90,
                          color: Colors.black,
                        ),
                        Text(
                          firstDistance.toString() + 'm',
                          style: normalTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        shape: BoxShape.rectangle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.timeline,
                          size: 90,
                          color: Colors.black,
                        ),
                        Text(
                          secondDistance.toString() + 'm',
                          style: normalTextStyle,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Badge(
                padding: EdgeInsets.all(10),
                badgeColor: Color(0xFF90303d),
                shape: BadgeShape.square,
                borderRadius: 10,
                badgeContent: Text(
                  ' Pricing ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'montserrat'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      shape: BoxShape.rectangle),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 90,
                        color: Colors.green,
                      ),
                      Text(
                        widget.firstRoom.price == null ? 'Contact' : '\$' +  widget.firstRoom.price.toString(),
                        style: normalTextStyle,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      shape: BoxShape.rectangle),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.attach_money,
                        size: 90,
                        color: Colors.green,
                      ),
                      Text(
                         widget.secondRoom.price == null ? 'Contact' : '\$' +  widget.secondRoom.price.toString(),
                        style: normalTextStyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
              child: Badge(
                padding: EdgeInsets.all(10),
                badgeColor: Colors.indigo,
                shape: BadgeShape.square,
                borderRadius: 10,
                badgeContent: Text(
                  ' Interaction ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'montserrat'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(40, 30, 10, 30),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        shape: BoxShape.rectangle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              size: 50,
                              color: Colors.red,
                            ),
                            Text(
                              widget.firstRoom.like.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.remove_red_eye,
                              size: 50,
                              color: Colors.indigo,
                            ),
                            Text(
                              widget.firstRoom.view.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                              maxLines: 1,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.chat,
                              size: 50,
                              color: Colors.amber,
                            ),
                            Text(
                              widget.firstRoom.comments == null ? '0' : widget.firstRoom.comments.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                              maxLines: 1,
                            )
                          ],
                        ),
                      ],
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(40, 30, 10, 30),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        shape: BoxShape.rectangle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              size: 50,
                              color: Colors.red,
                            ),
                            Text(
                              widget.secondRoom.like.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.remove_red_eye,
                              size: 50,
                              color: Colors.indigo,
                            ),
                            Text(
                              widget.secondRoom.view.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                              maxLines: 1,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.chat,
                              size: 50,
                              color: Colors.amber,
                            ),
                            Text(
                              widget.secondRoom.comments == null ? '0' : widget.secondRoom.comments.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                              maxLines: 1,
                            )
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );

    return Layout(mainContent);
  }
}

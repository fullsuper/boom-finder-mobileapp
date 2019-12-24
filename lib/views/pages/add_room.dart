import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:boom_finder_dev/models/room.dart';
import 'package:boom_finder_dev/views/utils/DialogUtils.dart';
import 'package:boom_finder_dev/views/widgets/disclaimer/disclaimer.dart';
import 'package:boom_finder_dev/views/widgets/textField/FilledBorderTextField.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as prefix0;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import './../layouts/_layout.dart';

final databaseReference = Firestore.instance;

class AddRoom extends StatefulWidget {
  File imageFile;
  String fileName = 'img-' + Random().nextInt(100000).toString() + '.jpg';
  String imageURL;

  Map<String, Marker> _markers = new Map<String, Marker>();

  GeoPoint _location = new GeoPoint(0, 0);

  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  Completer<GoogleMapController> _mapController = Completer();

  TextEditingController _titlController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  Future _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: prefix0.LocationAccuracy.best);

    return currentLocation;
  }

  Future<void> _moveToPosition(Position pos) async {
    final GoogleMapController mapController = await this._mapController.future;
    if (mapController == null) return;
    print('moving to position ${pos.latitude}, ${pos.longitude}');
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude, pos.longitude),
      zoom: 20.0,
      bearing: 192.8334901395799,
    )));
  }

  Future _getLocationByAddress() async {
    List<Placemark> placeMarks =
        await Geolocator().placemarkFromAddress(this._addressController.text);

    if (placeMarks != null && placeMarks.isNotEmpty) {
      Placemark addressPoint = placeMarks[0];
      _moveToPosition(addressPoint.position);

      setState(() {
        widget._markers["Current"] = Marker(
          markerId: MarkerId(addressPoint.locality),
          position: LatLng(
              addressPoint.position.latitude, addressPoint.position.longitude),
          infoWindow: InfoWindow(
              title: addressPoint.thoroughfare + ', ' + addressPoint.locality),
          draggable: true,
        );
        //print('MARKER LENGTH ' + widget._markers.length.toString());
      });
    }
  }

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      widget.imageFile = tempImage;
    });
  }

  bool isValid() {
    if (this._nameController.text.isEmpty ||
        this._descController.text.isEmpty ||
        this._titlController.text.isEmpty) {
      return false;
    }

    return true;
  }

  Future __uploadToStorage() async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child(widget.fileName);
    final StorageUploadTask task = storageReference.putFile(widget.imageFile);
    final StorageTaskSnapshot downloadUrl = await task.onComplete;
    final String url = await downloadUrl.ref.getDownloadURL();

    setState(() {
      widget.imageURL = url;
    });
  }

  Future _addRoom(BuildContext context) async {
    if (!isValid()) {
      showWarningAlert(
          context: context,
          title: 'Missing information',
          description: 'Should fill all above information'
      );
      return;
    }

    if (widget.imageFile != null) {
      await __uploadToStorage();
    } else {
      showWarningAlert(
          context: context,
          title: 'Image is Required',
          description: 'You need to select at least 1 image'
      );
      return;
    }


    Room newRoom = Room(
        title: _titlController.text,
        description: _descController.text,
        name: _nameController.text,
        image: widget.imageURL,
        like: 0,
        view: 0,
        location: GeoPoint(
            widget._markers["Current"].position.latitude,
            widget._markers["Current"].position.longitude
        )
    );

    await databaseReference.collection('Room').add(newRoom.toJson());
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Container(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Disclaimer(
              text: 'Room Name',
            ),
            FilledBorderTextField(
              textEditingController: this._titlController,
              hintText: 'Enter Room Name',
              fill: Colors.white,
            ),
            Disclaimer(
              text: 'Room Title',
            ),
            FilledBorderTextField(
              textEditingController: this._nameController,
              hintText: 'Enter Room Title',
              fill: Colors.white,
            ),
            Disclaimer(
              text: 'Description',
            ),
            FilledBorderTextField(
              type: TextInputType.multiline,
              textEditingController: this._descController,
              hintText: 'Enter Description',
              lines: 4,
              fill: Colors.white,
            ),
            Disclaimer(
              text: 'Images',
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.imageFile != null
                      ? '...' +
                          widget.imageFile.path.toString().substring(
                              widget.imageFile.path.toString().length - 30,
                              widget.imageFile.path.toString().length - 1)
                      : 'Choose the image'),
                  RaisedButton(
                    child: Text(widget.imageFile != null ? 'Change' : 'Choose'),
                    onPressed: () => getImage(),
                  ),
                ],
              ),
            ),
            widget.imageFile != null
                ? Container(
                    height: 200,
                    child: Image.file(widget.imageFile),
                  )
                : SizedBox.shrink(),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: FilledBorderTextField(
                      textEditingController: this._addressController,
                      hintText: 'Enter the Address',
                      fill: Colors.white,
                    ),
                    padding: EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width * 0.81,
                  ),
                  FloatingActionButton(
                    onPressed: _getLocationByAddress,
                    tooltip: 'Get Location',
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            Disclaimer(
              text: 'Locate your position',
            ),
            Container(
              height: 400,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: GoogleMap(
                padding: EdgeInsets.symmetric(vertical: 30),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
                rotateGesturesEnabled: true,
                zoomGesturesEnabled: true,
                indoorViewEnabled: true,
                mapToolbarEnabled: true,
                trafficEnabled:    true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      widget._location.latitude, widget._location.longitude),
                  zoom: 2.0,
                ),
                onMapCreated: (GoogleMapController controller) async {
                  this._mapController.complete(controller);
                  var location = await _getLocation();

                  controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        bearing: 192.8334901395799,
                        target: LatLng(location.latitude, location.longitude),
                        zoom: 20
                    ),
                  ));
                  setState(() {
                    widget._markers.clear();
                    widget._markers["Current"] = Marker(
                      markerId: MarkerId("curr_loc"),
                      position: LatLng(location.latitude, location.longitude),
                      infoWindow: InfoWindow(title: 'Your Location'),
                      draggable: true,
                    );
                  });
                },
                onTap: (LatLng loc) {
                  setState(() {
                    print(widget._markers["Current"].position.longitude);
                    widget._markers.clear();
                    widget._markers["Current"] = Marker(
                      markerId: MarkerId("curr_loc"),
                      position: LatLng(loc.latitude, loc.longitude),
                      infoWindow: InfoWindow(title: 'My Room Here'),
                      draggable: true,
                    );
                  });
                },
                markers: widget._markers.values.toSet(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  padding: EdgeInsets.all(20),
                  color: Colors.blueAccent,
                  elevation: 10,
                  onPressed: () => _addRoom(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Add Room',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(Icons.add)
                    ],
                  )),
            ),
          ],
        ),
      ),
    );

    return Layout(mainContent);
  }
}

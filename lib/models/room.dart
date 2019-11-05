import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String description;
  final String image;
  final int like;
  final GeoPoint location;
  final String name;
  final DocumentReference owner;
  final String title;
  final int view;

  Room.fromMap(Map<String, dynamic> map, {this.owner})
      : assert(map['description'] != null),
        assert(map['title'] != null),
        assert(map['like'] != null),
        assert(map['image'] != null),
        assert(map['view'] != null),
        description = map['description'].toString(),
        image = map['image'].toString(),
        like = map['like'],
        location = map['location'],
        name = map['name'].toString(),
        title = map['title'].toString(),
        view = map['view'];


  Room.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, owner: snapshot.reference);
}
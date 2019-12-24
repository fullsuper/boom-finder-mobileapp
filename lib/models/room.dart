import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String description;
  final String title;
  final String name;
  final String image;
  final GeoPoint location;
  final DocumentReference owner;
  final int view;
  final int like;
  final int price;

  Room(
      {this.title,
      this.name,
      this.description,
      this.image,
      this.location,
      this.view,
      this.like,
      this.owner,
      this.price});

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
        view = map['view'],
        price = map['price'];

  Room.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, owner: snapshot.reference);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'description': description,
        'title': title,
        'name': name,
        'image': image,
        'location': location,
        'owner': owner,
        'view': view,
        'like': like,
        'price': price
      };
}

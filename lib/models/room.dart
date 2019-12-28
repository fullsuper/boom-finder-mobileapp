import 'package:cloud_firestore/cloud_firestore.dart';

import 'comment.dart';

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
  final List<dynamic> comments;

  Room(
      {this.title,
      this.name,
      this.description,
      this.image,
      this.location,
      this.view,
      this.like,
      this.owner,
      this.price,
      this.comments});

  Room.fromMap(Map<String, dynamic> map, {this.owner})
      : description = map['description'].toString(),
        image = map['image'].toString(),
        like = map['like'],
        location = map['location'],
        name = map['name'].toString(),
        title = map['title'].toString(),
        view = map['view'],
        price = map['price'],
        comments = map['comments'];

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
        'price': price,
        'comments': comments
      };

/*  List<Comment> fromListMap(Map map){
    return map.entries.map((comment) => Comment(commen)).toList();

  }*/
}

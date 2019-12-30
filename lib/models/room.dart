import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  String description;
  String title;
  String name;
  String image;
  GeoPoint location;
  DocumentReference owner;
  int view;
  int like;
  int price;
  List<dynamic> comments;
  String documentId;

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
      this.comments,
      this.documentId});

  Room.fromMap(Map<String, dynamic> map, {this.owner, this.documentId})
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
      : this.fromMap(snapshot.data, owner: snapshot.reference, documentId: snapshot.documentID);

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
        'comments': comments,
      };

  void countUpView(){
    this.view++;
  }

  void countUpLike(){
    this.like++;
  }

  void addComment(String comment) {
    List<dynamic> preComment = List<dynamic>.from(comments);

    preComment.add({
      'comment': comment,
      'date' : Timestamp.now()
    });

    this.comments =  preComment;
  }
}

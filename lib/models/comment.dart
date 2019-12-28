import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String comment;
  final Timestamp date;

  Comment({this.comment,this.date});

  Comment.fromMap(Map<String, dynamic> map)
      : comment = map['comment'].toString(),
        date = map['date'];

  Map<String, dynamic> toJson() => <String, dynamic>{
    'comment': comment,
    'date': date,
  };
}

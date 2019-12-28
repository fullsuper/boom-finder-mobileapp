import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final String comment, owner, avatar;
  final Timestamp time;

  CommentItem(
      {this.comment,
      this.owner = 'Unknown',
      this.avatar =
          'https://d12swbtw719y4s.cloudfront.net/images/c3jRZQtA/lOHfuGybE2DtFw8RGTW8/nannot.jpeg?w=620',
      this.time});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
      decoration: BoxDecoration(

        gradient: LinearGradient(
            colors: [Colors.white.withOpacity(0.5) , Colors.grey[300].withOpacity(0.5), Colors.blueGrey[200].withOpacity(0.5)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,

        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: Image(

              width: 100,
              height: 100,
              image: NetworkImage(avatar),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    owner,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 20, height: 1.2, fontWeight: FontWeight.w900),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: 60.0,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        comment,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                time != null
                    ? Container(
                        child: Text(
                          time.toDate().day.toString() +
                              '/' +
                              time.toDate().month.toString() +
                              '/' +
                              time.toDate().year.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : null,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

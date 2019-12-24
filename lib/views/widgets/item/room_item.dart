import 'package:boom_finder_dev/models/room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const int VALID_DESCRIPTION_LENGTH = 55;

class RoomItem extends StatelessWidget {
  Room room;
  Function onTap;

  RoomItem({this.room, this.onTap});

  @override
  Widget build(BuildContext context) {
    String validDescription = room.description.length > VALID_DESCRIPTION_LENGTH
        ? room.description.substring(0, VALID_DESCRIPTION_LENGTH-3) + '..'
        : room.description;

    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        margin: EdgeInsets.all(3.0),
        padding: EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width / 2 - 10,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Image(
              width: MediaQuery.of(context).size.width / 2 - 10,
              height: 200,
              fit: BoxFit.cover,
              image: NetworkImage(this.room.image),
              alignment: Alignment.center,

            ),
            Text(
              this.room.title,
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 35,
              child: Text(validDescription),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.people),
                    Text('hardcode'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                    ),
                    Text('hardcode'),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.remove_red_eye),
                    Text(this.room.view.toString()),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      this.room.like.toString(),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

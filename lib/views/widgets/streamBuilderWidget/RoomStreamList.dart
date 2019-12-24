import 'package:boom_finder_dev/models/room.dart';
import 'package:boom_finder_dev/views/pages/detail.dart';
import 'package:boom_finder_dev/views/widgets/item/room_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomStreamList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Room').snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Container()
              : Wrap(
                  alignment: WrapAlignment.start,
                  children: snapshot.data.documents.map((data) {
                    final room = Room.fromSnapshot(data);

                    return RoomItem(
                      room: room,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailPage.routeName,
                          arguments: room);
                      },
                    );
                  }).toList(),
                );
        });
  }
}

import 'package:boom_finder_dev/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestFbPage extends StatefulWidget {
  @override
  _TestFbPageState createState() => _TestFbPageState();
}

class _TestFbPageState extends State<TestFbPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Firebase')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    // TODO: get actual snapshot from Cloud Firestore
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Room').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }
}

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final room = Room.fromSnapshot(data);

    return Card(
      key: ValueKey(room.name),
        child: ListTile(
          leading: Image(
            image: NetworkImage(
                room.image
            ),
          ),
          title: Text(room.title),
          subtitle: Text(room.description),
          trailing:Icon(Icons.more_vert),
      ),
    );
  }



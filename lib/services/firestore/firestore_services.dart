import 'package:boom_finder_dev/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = Firestore.instance;

class FsService {
  static Future<List<Room>> getAllRoom() async {
    await databaseReference.collection('Room')
        .getDocuments()
        .then((QuerySnapshot snapshot){
      List<Room> rooms;
      snapshot.documents.forEach((room) => rooms.add(Room.fromSnapshot(room)));
      return rooms;
    }).catchError((error) {
      print('Some errors when fetch data: $error');
    });

    return null;
  }
}

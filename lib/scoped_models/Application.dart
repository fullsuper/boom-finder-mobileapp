import 'package:boom_finder_dev/constants/auth.dart';
import 'package:boom_finder_dev/models/room.dart';
import 'package:boom_finder_dev/views/pages/add_room.dart';
import 'package:boom_finder_dev/views/pages/compare_details.dart';
import 'package:boom_finder_dev/views/pages/compare_list.dart';
import 'package:boom_finder_dev/views/pages/detail.dart';
import 'package:boom_finder_dev/views/pages/home.dart';
import 'package:boom_finder_dev/views/pages/list_room.dart';
import 'package:boom_finder_dev/views/pages/login.dart';
import 'package:boom_finder_dev/views/pages/register.dart';
import 'package:boom_finder_dev/views/pages/search_room.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => AuthConstants.userId != null && AuthConstants.userId.isNotEmpty ?  HomePage() : LoginPage(),
        '/register': (context) => RegisterPage(),
        '/list_room': (context) => RoomsPage(),
        '/compare_list': (context) => CompareListRoom(),
        '/add_room': (context) => AddRoom(),
        '/search_room': (context) => SearchRoomPage(),
        '/post': (context) => Center(
              child: Text('Post Page'),
            )
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case DetailPage.routeName:
            {
              return MaterialPageRoute(
                builder: (context) => DetailPage(room: settings.arguments as Room),
              );
            }
          case CompareDetail.routeName:
            {
              List<Room> listRoom = settings.arguments as List<Room>;
              return MaterialPageRoute(
                builder: (context) => CompareDetail(firstRoom: listRoom[0], secondRoom: listRoom[1]),
              );
            }
          default:
            return MaterialPageRoute(
              builder: (context) => Scaffold()
            );
        }
      },
      title: 'Room Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

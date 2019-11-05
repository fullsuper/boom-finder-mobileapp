import 'package:boom_finder_dev/views/pages/detail.dart';
import 'package:boom_finder_dev/views/pages/home.dart';
import 'package:boom_finder_dev/views/pages/list_room.dart';
import 'package:boom_finder_dev/views/pages/testFlutterPage.dart';

import 'package:flutter/material.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  Widget _page = TestFbPage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _page
    );
  }
}



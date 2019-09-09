import 'package:boom_finder_dev/views/pages/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  Widget _page = HomePage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _page
    );
  }
}



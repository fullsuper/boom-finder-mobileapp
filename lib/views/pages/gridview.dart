import 'package:boom_finder_dev/views/layouts/_layout.dart';
import 'package:flutter/material.dart';

class Page extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Page> {

  Widget app = new Container(
    color: Colors.white30,
    child: new GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: <String>[
          'http://www.for-example.org/img/main/forexamplelogo.png',
          'http://www.for-example.org/img/main/forexamplelogo.png',
          'http://www.for-example.org/img/main/forexamplelogo.png',
          'http://www.for-example.org/img/main/forexamplelogo.png',
          'http://www.for-example.org/img/main/forexamplelogo.png',
          'http://www.for-example.org/img/main/forexamplelogo.png',
          'http://www.for-example.org/img/main/forexamplelogo.png',
          'http://www.for-example.org/img/main/forexamplelogo.png',
          'http://www.for-example.org/img/main/forexamplelogo.png',
          'http://www.for-example.org/img/main/forexamplelogo.png',
          'http://www.for-example.org/img/main/forexamplelogo.png',
        ].map((String url) {
          return new GridTile(
              child: new Image.network(url, fit: BoxFit.cover));
        }).toList()),
  );

  @override
  Widget build(BuildContext context) {
    return Layout(app);
  }
}
import 'package:flutter/material.dart';
import './../widgets/appbar/top_bar.dart';
import './../widgets/appbar/bottom_bar_redesign.dart';

class Layout extends StatefulWidget {
  Widget bodyContent;
  Layout(this.bodyContent);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Room Finder',),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [Color(0xFFFFFFEE), Color(0xFF999999)], // whitish to gray
            tileMode: TileMode.repeated,
          )
        ),
        child:       widget.bodyContent,
      ),
      bottomNavigationBar: BottomBar(context),
    );
  }
}

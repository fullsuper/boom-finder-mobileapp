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
      appBar: TopBar('Hello world'),
      body: widget.bodyContent,
      bottomNavigationBar: BottomBar(),
    );
  }
}

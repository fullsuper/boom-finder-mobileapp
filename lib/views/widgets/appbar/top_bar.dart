import 'package:flutter/material.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget{
  final String title;

  TopBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
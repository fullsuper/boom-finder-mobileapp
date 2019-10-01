import 'package:flutter/material.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget{
  final String title;

  TopBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        this.title,
        textAlign: TextAlign.center,),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search
          ),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
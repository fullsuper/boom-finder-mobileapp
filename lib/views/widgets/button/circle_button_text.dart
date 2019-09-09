import 'package:flutter/material.dart';

class CircleIconButtonText extends StatefulWidget {
  String text;
  IconData icon;
  Function action;

  CircleIconButtonText(this.text, this.icon, this.action);

  @override
  State<StatefulWidget> createState() => _CircleIconButtonTextState();
}

class _CircleIconButtonTextState extends State<CircleIconButtonText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {},
              child: new Icon(
                Icons.pause,
                color: Colors.blue,
                size: 35.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.white,
              padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
              child:
              Text(
                'Hello World',
              ),),
          ],
        ),
      ],
    );
  }
}
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
    return RawMaterialButton(
      padding: EdgeInsets.all(10.0),
      onPressed: widget.action,
      child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey
              ),
              child: Icon(
                widget.icon,
                color: Colors.blue,
                size: 35.0,
              ),
              padding: EdgeInsets.all(15.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ),
          ],
        ),
    );
  }
}

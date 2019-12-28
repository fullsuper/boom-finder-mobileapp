import 'package:flutter/material.dart';

class CircleIconButtonText extends StatefulWidget {
  String text;
  Icon icon;
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    0.4,
                    0.9
                  ],
                  colors: [
                    Colors.blue,
                    Colors.indigo,
                    Colors.teal
                  ]),
              shape: BoxShape.circle,
            ),
            child: widget.icon,
            padding: EdgeInsets.all(15.0),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              widget.text,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:boom_finder_dev/constants/common/enumeration.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  SizeType sizeType;
  ShapeType shapeType;
  bool isCorner;
  String text;
  Function action;
  CircleButton({
    this.sizeType,
    this.shapeType,
    this.isCorner,
    this.text,
    this.action
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text(text),
        onPressed: action,

    );
  }
}
import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  String text;
  double paddingTop, paddingBottom;
  Color color;

  Disclaimer(
      {@required this.text,
      this.paddingTop = 5,
      this.paddingBottom = 0,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: this.paddingTop,
        bottom: this.paddingBottom,
        right: 10,
      ),
      child: Text(
        this.text,
        style: TextStyle(color: this.color,
          fontSize: 16,
          fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          fontFamily: 'Cento'
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class VerticalCard extends StatelessWidget {
  String imageSrc;
  String title;
  String description;
  Function onClick;

  VerticalCard({this.imageSrc, this.title, this.description, this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Column(
          children: <Widget>[
            ClipRect(
              child: Align(
                alignment: Alignment.center,
                heightFactor: 0.8,
                child: Image.network(
                    'https://images.unsplash.com/photo-1562184552-997c461abbe6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),

              child: Align(
                alignment: Alignment.topLeft,
              child: Text(
                this.title,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w700
                ),
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  this.description,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void showWarningAlert({BuildContext context, String title, String description}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title:
      Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title),
                Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 30,
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.deepOrange,
            )
          ],
        ),
      ),
      content: Text(description),
      actions: <Widget>[
        RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          color: Colors.blueGrey,
          child: Text(
            'Close',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}
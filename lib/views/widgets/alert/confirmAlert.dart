import 'package:flutter/material.dart';


class ConfirmAlert extends StatefulWidget {
  BuildContext context;

  ConfirmAlert(this.context);

  @override
  State<StatefulWidget> createState() => _ConfirmAlertState();
}

class _ConfirmAlertState extends State<ConfirmAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Text('Question'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Are you crazy!?'),
           /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ])*/
          ],
        ),
      ),
      actions: <Widget>[
            RaisedButton(
              child: Text('Yes',),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(3)
              ),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text('No'),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(3)
              ),
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
      ],
    );
  }
}
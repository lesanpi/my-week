import 'package:flutter/material.dart';
import 'package:my_week/Balance/model/movement.dart';

class ItemInfo extends StatelessWidget{

  final Movement detail;

  ItemInfo(this.detail);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            detail.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17
            ),
          ),
          Text(
            "${detail.dateTime.hour}:${detail.dateTime.minute}",
            style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                fontWeight: FontWeight.w300,
                fontSize: 13
            ),
          )
        ],
      ),
      margin: EdgeInsets.only(
          left: 15
      ),
    );
  }
}
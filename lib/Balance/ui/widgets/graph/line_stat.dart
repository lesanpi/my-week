import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LineStat extends StatelessWidget{

  double height;
  Color color;

  LineStat({ Key key, @required this.height, this.color} );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(color == null) {
      color = Color.fromRGBO(255, 255, 255, 0.05);
    }
    if(height.isNaN){
      if(color == Color.fromRGBO(255, 255, 255, 0.05)) height = 180;
      else height = 0;
    }

    return Container(
      width: 8,
      height: height == 180 ? 204 : height,
      margin: EdgeInsets.only(
          top: height == 0 ? 0 : 12
      ),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(9))
      ),
    );
  }

}
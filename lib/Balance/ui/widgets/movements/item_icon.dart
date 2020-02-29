import 'package:flutter/material.dart';

class ItemIcon extends StatelessWidget{

  final IconData icon;

  ItemIcon({Key key, @required this.icon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.05),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Center(
        child: Icon(icon, size: 30),
      ),
    );
  }

}
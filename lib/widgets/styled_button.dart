import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget{

  final VoidCallback onTap;
  double height;
  final Color color;
  final String text;

  StyledButton({Key key,@required this.onTap, @required this.color, @required this.text, this.height});

  @override
  Widget build(BuildContext context) {

    if(height == null) height = 50;

    // TODO: implement build
    return InkWell(
      child: Container(
        width: 180,
        child: Center(
          child: Text(text),
        ),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        height: height,
        margin: EdgeInsets.only(
            top: 10
        ),
      ),
      onTap: onTap,
    );
  }

}
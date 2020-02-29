import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget{

  double height = 0.0;

  GradientBackground({Key key, this.height});//height = null full screen

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if(height == null){
      height = screenHeight;
    }

    return Container(
      width: screenWidth,
      height: height,
      decoration: BoxDecoration(
          color: Color(0xFF000a12), //Color(0xFF000a12)
      ),

    );
  }

}
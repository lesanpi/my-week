import 'package:flutter/material.dart';

class TextInput extends StatelessWidget{

  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  double width;
  int maxLines = 1;
  double left;
  TextInput({
    Key key,
    @required this.hintText,
    @required this.inputType,
    @required this.controller,
    this.width,
    this.left,
    this.maxLines
  });



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(width == null){
      width = 200;
    }
    if(left == null){
      left = 10;
    }

    return Container(
      padding: EdgeInsets.only(
        right: 5, left: 10
      ),
      width: width,
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 15,
          fontFamily: "Lato",
          color: Colors.blueGrey,
          fontWeight: FontWeight.w300
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor:  Color(0xFFf5f5f5),
          border: InputBorder.none,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFf5f5f5)
            ),
            borderRadius: BorderRadius.all(Radius.circular(9))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFFf5f5f5)
              ),
              borderRadius: BorderRadius.all(Radius.circular(9))
          )
        ),
      ),
    );
  }

}
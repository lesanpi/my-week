import 'package:flutter/material.dart';

class HeaderAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 40, left: 20
            ),
            child: SizedBox(
              height: 85,
              width: 45,
              child: IconButton(
                icon: Icon(Icons.keyboard_arrow_left, color: Colors.white70, size: 35),
                onPressed: (){

                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
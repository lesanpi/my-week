import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FinancialStatus extends StatelessWidget{

  final String title;
  final int cantity;
  double sizeTitle;
  double sizeCantity;

  FinancialStatus({ Key key, this.title, this.cantity, this.sizeTitle, this.sizeCantity});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(sizeTitle == null){
      sizeTitle = 15;
      sizeCantity = 28;
    }

    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white30,
              fontSize: sizeTitle
            ),
          ),
          Text(
            "\$ $cantity",
            style: TextStyle(
              color: Colors.white,
              fontSize: sizeCantity,
              fontWeight: FontWeight.w600,
            ),

          )
        ],
      ),
    );
  }

}
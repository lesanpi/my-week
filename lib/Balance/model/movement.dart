import 'package:flutter/material.dart';

class Movement{

  final int cantity;
  bool income = false;
  final String title;
  final DateTime dateTime;
  final String type;


  Movement({Key key, @required this.cantity, @required this.title, @required this.dateTime, @required this.type, this.income,});

}
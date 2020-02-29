import 'package:flutter/material.dart';
import 'package:my_week/Balance/model/movement.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final int total;
  final List<Movement> movements;
  //myFavoritePlaces
  //myPlaces

  User({
    Key key,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.photoURL,
    @required this.total,
    this.movements
  });


}
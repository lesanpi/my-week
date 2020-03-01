import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_week/Balance/model/movement.dart';
import 'package:my_week/Balance/model/user.dart';
import 'package:my_week/Balance/ui/widgets/movements/item_detail.dart';
import 'cloud_firestore_api.dart';

class CloudFirestoreRepository{
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user)=> _cloudFirestoreAPI.updateUserData(user);
  void setUserTotalBalanceToZero(User user)=> _cloudFirestoreAPI.setUserTotalBalanceToZero(user);

  void createMovement(User user, Movement movement) => _cloudFirestoreAPI.createMovement(user, movement);

  List<Widget> buildMyMovements(List<DocumentSnapshot> movementsListSnapshot) => _cloudFirestoreAPI.buildMyMovements(movementsListSnapshot);

  List<int> returnIncomesSpents(List<DocumentSnapshot> movementsListSnapshot) => _cloudFirestoreAPI.returnIncomesSpents(movementsListSnapshot);


}
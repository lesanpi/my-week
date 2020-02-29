import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_week/Balance/model/movement.dart';
import 'package:my_week/Balance/model/user.dart';
import 'package:my_week/Balance/ui/widgets/movements/item_detail.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String MOVEMENTS = "movements";

  final Firestore _db = Firestore.instance;

  //registrar
  void updateUserData(User user) async{
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      //'total': user.total,
      //'movements': user.movements,
      'lastSignIn': DateTime.now()
    }, merge: true);
  }

  void createMovement(User user, Movement movement) async{
    CollectionReference ref = _db.collection(USERS).document(user.uid).collection(MOVEMENTS);
    ref.add({
      "title": movement.title,
      "cantity": movement.cantity,
      "income": movement.income,
      "day": movement.dateTime.day,
      "month": movement.dateTime.month,
      "year": movement.dateTime.year,
      "type": movement.type,
      "date": movement.dateTime.toUtc()
    });
  }

  List<Widget> buildMyMovements(List<DocumentSnapshot> movementsListSnapshot){
    List<ItemDetail> profilePlaces = List<ItemDetail>();
    if(movementsListSnapshot.length == 0 ) return [
      Container(
        height: 100,
        color: Colors.white,
        child: Center(
          child: Text("You don't have movements yet",
            style: TextStyle(
                color: Colors.black26,
                fontSize: 15
            ),
          ),
        ),
      )
    ];

    movementsListSnapshot.forEach((p) {

      profilePlaces.add(ItemDetail(
        detail: Movement(cantity: p.data['cantity'], title: p.data['title'], dateTime: p.data['date'].toDate(), type: p.data['type'], income: p.data['income']),
      ));

    });

    return profilePlaces;


  }

  List<int> returnIncomesSpents(List<DocumentSnapshot> movementsListSnapshot){
    List<int> incomeSpents = List<int>();
    int spents = 0;
    int incomes = 0;

    if(movementsListSnapshot.length == 0) {
      incomeSpents.add(incomes);
      incomeSpents.add(spents);


      return incomeSpents;
    }

    movementsListSnapshot.forEach((p) {

      if(p.data['income']) incomes = incomes + p.data['cantity'];
      else spents = spents + p.data['cantity'];

    });

    //print(spents);
    //print(incomes);

    incomeSpents.add(incomes);
    incomeSpents.add(spents);


    return incomeSpents;

  }

}
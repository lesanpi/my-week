import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_week/Balance/model/movement.dart';
import 'package:my_week/Balance/model/user.dart';
import 'package:my_week/Balance/repository/auth_repository.dart';
import 'package:my_week/Balance/repository/cloud_firestore_api.dart';
import 'package:my_week/Balance/repository/cloud_firestore_repository.dart';


class UserBloc implements Bloc{

  final _authRepository = AuthRepository();

  //FLujo de de datos - Strems
  //Stream - Firebase
  //StreamController
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;
  //Casos de uso de la aplicacion

  //1. Signin a la aplicacion
  Future<FirebaseUser> signIn()  {
    return _authRepository.signInFirebase();
  }
  //2. Registrar usuario
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);
  void setUserTotalBalanceToZero(User user) => _cloudFirestoreRepository.setUserTotalBalanceToZero(user);

  Stream<QuerySnapshot> usersStream = Firestore.instance.collection(CloudFirestoreAPI().USERS).snapshots();
  Stream<QuerySnapshot> userStream(User user) => Firestore.instance.collection(CloudFirestoreAPI().USERS).where("uid", isEqualTo: user.uid).snapshots();

  Stream<QuerySnapshot> userMovementsStream(User user, DateTime date){

    return Firestore.instance.collection(CloudFirestoreAPI().USERS).document(user.uid).collection("movements")
        .where("year", isEqualTo: date.year)
        .where("month", isEqualTo: date.month)
        .where("day", isEqualTo: date.day)
        //.where("income", isEqualTo: false)
        .orderBy("date")
        .snapshots();
  }

  Stream<QuerySnapshot> userSpentsIncome(User user, DateTime date){

    return Firestore.instance.collection(CloudFirestoreAPI().USERS).document(user.uid)
        .collection("movements")
        .where("year", isEqualTo: date.year)
        .where("month", isEqualTo: date.month)
        .where("day", isEqualTo: date.day)
        //.orderBy("date")
        .snapshots();

  }

  List<Widget> buildMyMovements(List<DocumentSnapshot> movementsListSnapshot) => _cloudFirestoreRepository.buildMyMovements(movementsListSnapshot);

  List<int> returnIncomesSpents(List<DocumentSnapshot> movementsListSnapshot) => _cloudFirestoreRepository.returnIncomesSpents(movementsListSnapshot);

  void createMovement(User user, Movement movement) => _cloudFirestoreRepository.createMovement(user, movement);

  //Signout
  signOut(){
    _authRepository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}
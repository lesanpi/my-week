import 'package:flutter/material.dart';
import 'package:my_week/Balance/bloc/bloc_user.dart';
import 'package:my_week/Balance/model/user.dart';
import 'package:my_week/Balance/ui/screens/main_screen.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_week/widgets/button_green.dart';
import 'package:my_week/widgets/gradient_background.dart';

class SignInScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInScreen();
  }

}

class _SignInScreen extends State<SignInScreen>{

  UserBloc userBloc;
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of(context);
    screenWidth = MediaQuery.of(context).size.width;

    return _handleCurrentSession();
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot)
      {
        //snapshot - data - object user
        if (snapshot.hasData) {
          return BlocProvider<UserBloc>(
            bloc: UserBloc(),
            child: MainScreen(),
          );
        } else if (snapshot.hasError) {
          return Text("Ocurrio un error en la transmision de datos");
        } else if (snapshot.connectionState != ConnectionState.waiting) {
          return signInGoogleUI();
        } else {
          return Container(
            color: Color(0xFF584CD1),
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 70,
                      width: 70,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,)
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text("Cargando", style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "Lato",
                        decoration: TextDecoration.none)
                    ),)
                ]
            ),
          );
        }
      }
    );
  }

  Widget signInGoogleUI(){
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Container(
                  width: screenWidth,
                  child: Text("Start saving your money",
                    style: TextStyle(
                      fontSize: 37.0,
                      fontFamily: "Lato",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ButtonGreen(text: "Login with Gmail", onPressed: (){
                userBloc.signOut();
                userBloc.signIn().then((FirebaseUser user){

                  userBloc.updateUserData(User(
                      uid: user.uid,
                      name: user.displayName,
                      email: user.email,
                      photoURL: user.photoUrl,
                      total: 0
                  ));
                });
              },
                width: 300.0,
                height: 50.0,
              )
            ],
          ),
        ],
      ),
    );
  }

}

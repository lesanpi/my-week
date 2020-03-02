import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:my_week/Balance/bloc/bloc_user.dart';
import 'package:my_week/Balance/model/user.dart';
import 'package:my_week/Balance/ui/widgets/graph/graph_income_spent.dart';
import 'package:my_week/Balance/ui/widgets/movements/details_list.dart';
import 'package:my_week/Balance/ui/screens/user_bar.dart';
import 'package:my_week/widgets/gradient_background.dart';
import 'package:my_week/widgets/header_app_bar.dart';

class MainScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainScreen();
  }

}

class _MainScreen extends State<MainScreen>{

  double spaceExtra = 0;
  UserBloc userBloc;
  User user;
  int currentIndex = 0;
  SwiperController _controller = SwiperController();

  void _incrementSpace() {
    /*setState(() {
      if(spaceExtra == 0) spaceExtra = 280;
      else spaceExtra = 0;
    });*/
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
      stream: userBloc.streamFirebase,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return CircularProgressIndicator();

          case ConnectionState.none:

            return CircularProgressIndicator();

          case ConnectionState.active:
            return showProfileData(snapshot);
          case ConnectionState.done:
            return showProfileData(snapshot);
            default:
          return showProfileData(snapshot);

        }
      },
    );


  }

  Widget showProfileData(AsyncSnapshot snapshot) {

    if (!snapshot.hasData || snapshot.hasError) {
      return Container(
        margin: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 30.0
        ),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("No se pudo cargar la informacion. Haz login")
          ],
        ),
      );
    } else {
      user = User(uid: snapshot.data.uid,name: snapshot.data.displayName, email: snapshot.data.email, photoURL: snapshot.data.photoUrl, total: 0);
      return StreamBuilder(
        stream: userBloc.userStream(user),
        builder: (context, AsyncSnapshot _snapshot){

          switch(_snapshot.connectionState){
            case ConnectionState.waiting:
              return Container();
            case ConnectionState.done:
              if(_snapshot.data.documents[0]['total'] == null) userBloc.setUserTotalBalanceToZero(user);
              User _user = User(uid: _snapshot.data.documents[0]['uid'], name: _snapshot.data.documents[0]['name'],
                  email: _snapshot.data.documents[0]['email'], photoURL: _snapshot.data.documents[0]['photoURL'],
                  total: _snapshot.data.documents[0]['total']);
              return _app(_user);

            case ConnectionState.active:
              if(_snapshot.data.documents[0]['total'] == null) userBloc.setUserTotalBalanceToZero(user);
              User _user = User(uid: _snapshot.data.documents[0]['uid'], name: _snapshot.data.documents[0]['name'],
                  email: _snapshot.data.documents[0]['email'], photoURL: _snapshot.data.documents[0]['photoURL'], total: _snapshot.data.documents[0]['total']);
              return _app(_user);

            case ConnectionState.none:
              return Container();
            default:

              if(_snapshot.data.documents[0]['total'] == null) userBloc.setUserTotalBalanceToZero(user);
              User _user = User(uid: _snapshot.data.documents[0]['uid'], name: _snapshot.data.documents[0]['name'],
                  email: _snapshot.data.documents[0]['email'], photoURL: _snapshot.data.documents[0]['photoURL'], total: _snapshot.data.documents[0]['total']);

              return _app(_user);

          }
        },

      );


    }
  }

  Widget _app(User _user){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBackground(),
          //HeaderAppBar(),
          ListView(
            children: <Widget>[
              UserBar(
                onPressed: _incrementSpace,
                user: _user,
              ),
              Stack(
                children: <Widget>[
                  IncomeSpent(user: _user),
                  Column(
                    children: [
                      DetailsList(_user, "Movements", 485 , borderRad: true),
                      //DetailsList(user, "Notification", 0, height: 400, borderRad: false,)
                    ],
                  )
                ],
              )
            ],
          ),
          HeaderAppBar(),
        ],
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:my_week/Balance/bloc/bloc_user.dart';
import 'package:my_week/Balance/model/user.dart';
import 'package:my_week/Balance/ui/screens/dialog_new_movement.dart';
import 'package:my_week/widgets/floating_action_button.dart';

// ignore: must_be_immutable
class DetailsList extends StatelessWidget{

  final String title;
  final double top;
  final double height;
  final bool borderRad;

  final User user;
  UserBloc userBloc;

  DetailsList(this.user, this.title, this.top, {Key key, this.height = 435, this.borderRad});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    userBloc = BlocProvider.of<UserBloc>(context);
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    void _showDialog(){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return DialogNewMovement(
            user: user
          );
        }
      );
    }

    Widget detailList(AsyncSnapshot snapshot){

      return Container(
        padding: EdgeInsets.only(
          bottom: 30
        ),
        child: Column(
          children: userBloc.buildMyMovements(snapshot.data.documents),
        ),
      );
    }

    Widget emptyList = Container(
      height: 150,
      color: Colors.white,
      child: Center(
        child: Text("You don't have movements yet",
          style: TextStyle(
              color: Colors.black26,
              fontSize: 15
          ),
        ),
      ),
    );

    return Container(
      width: screenWidth,
      //height: height,
      margin: EdgeInsets.only(
          top: top
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRad ? BorderRadius.only(
            topLeft: Radius.circular(60), topRight: Radius.circular(60)
        ) : BorderRadius.only(
            topLeft: Radius.circular(0), topRight: Radius.circular(0)
        ) ,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(
                  left: 48,
                  top: 35
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 130
                    ),
                    child: FloatingActionButtonFab(iconData: Icons.add, onPressed: (){
                      _showDialog();
                    },
                      color: Color(0xFF000a12),
                    ),
                  )
                ],
              )
          ),
          StreamBuilder(
            stream: userBloc.userMovementsStream(user, DateTime.now()),
            builder: (context, AsyncSnapshot snapshot){
              switch(snapshot.connectionState){

                case ConnectionState.waiting:
                  //print('waiting list');
                  return emptyList;

                case ConnectionState.done:
                  //print('done');
                  return detailList(snapshot);

                case ConnectionState.active:
                  //print('active');
                  return detailList(snapshot);

                case ConnectionState.none:
                  //print('none');
                  return emptyList;

                default:
                  //print('default');
                  return detailList(snapshot);
              }
            },
          ),

        ],
      ),
    );


  }

}

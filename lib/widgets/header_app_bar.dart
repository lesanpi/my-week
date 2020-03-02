import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:my_week/Balance/bloc/bloc_user.dart';

class HeaderAppBar extends StatelessWidget{

  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.only(
                  top: 40, left: 20
              ),
              //color: Colors.amber,
              child: SizedBox(
                height: 85,
                width: 85,
                child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left, color: Colors.white70, size: 35),
                  onPressed: (){
                    print("Hola");
                    userBloc.signOut();

                  },
                ),
              ),
              height: 85,
              width: 45,
            ),
            onTap: (){
              print("Hola");
              userBloc.signOut();
            },
          )
        ],
      ),
    );
  }
}
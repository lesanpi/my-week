import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:my_week/Balance/bloc/bloc_user.dart';
import 'package:my_week/Balance/ui/widgets/graph/financial_status.dart';
import 'package:my_week/Balance/model/user.dart';

// ignore: must_be_immutable
class UserBar extends StatelessWidget{

  final VoidCallback onPressed;
  final User user;
  UserBloc userBloc;

  UserBar({@required this.onPressed, @required this.user});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      //color: Color.fromRGBO(255, 255, 255, 0.05),
        height: 75,
        margin: EdgeInsets.only(
            top: 85
        ),
        padding: EdgeInsets.only(
            left: 75
        ),
        child: StreamBuilder(
          stream: userBloc.userStream(user),
          builder: (context, AsyncSnapshot snapshot){

            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Container();
              case ConnectionState.done:

                return _userBar(snapshot);

              case ConnectionState.active:
                return _userBar(snapshot);

              case ConnectionState.none:
                return Container();
              default:

                return _userBar(snapshot);

            }
          },

        )
    );

  }

  Widget _userBar(AsyncSnapshot snapshot){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FinancialStatus(
          title: "Total Balance",
          cantity: snapshot.data.documents[0]['total'] as int,
          sizeTitle: 18,
          sizeCantity: 32,
        ),
        InkWell(
          child: Container(
            height: 65,
            width: 65,
            margin: EdgeInsets.only(
                left: 60,
                right: 20
            ),
            child: FittedBox(
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(65),
                    image: DecorationImage(
                        image: NetworkImage(user.photoURL)
                    ),
                  color: Color.fromRGBO(255, 255, 255, 0.05)
                ),
              ),
            ),
          ),
          onTap: onPressed,
        )
      ],
    );

  }

}
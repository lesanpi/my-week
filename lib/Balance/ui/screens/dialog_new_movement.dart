import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:my_week/Balance/bloc/bloc_user.dart';
import 'package:my_week/Balance/model/movement.dart';
import 'package:my_week/Balance/model/user.dart';
import 'package:my_week/utils.dart';
import 'package:my_week/widgets/styled_button.dart';
import 'package:my_week/widgets/text_input.dart';

// ignore: must_be_immutable
class DialogNewMovement extends StatefulWidget{

  final User user;

  DialogNewMovement({Key key, @required this.user});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DialogNewMovement();
  }


}

class _DialogNewMovement extends State<DialogNewMovement>{

  UserBloc userBloc;
  final _controllerTitle = TextEditingController();
  final _controllerCantity = TextEditingController();
  String typeSelected = 'car';
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    userBloc = BlocProvider.of<UserBloc>(context);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
          height: 150,
          width: 600,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  DropdownButton(
                    onChanged: (String newValue){
                      setState(() {
                        typeSelected = newValue;
                      });
                    },
                    items: Utils.ICON_DATA_STRING.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Icon(Utils.ICON_DATA_MAP[value], size: 35, color: Colors.black,),
                      );
                    }).toList(),
                    icon: null,
                    elevation: 0,
                    iconSize: 0,
                  ),
                  TextInput(
                    hintText: "Title",
                    inputType: null,
                    maxLines: 1,
                    controller: _controllerTitle,
                    width: 145,
                    left: 5,
                  ),
                  TextInput(
                    hintText: "\$",
                    inputType: TextInputType.number,
                    maxLines: 1,
                    controller: _controllerCantity,
                    width: 70,
                    left: 0,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  StyledButton(
                    onTap: (){
                      userBloc.createMovement(
                          widget.user,
                          Movement(
                              cantity: int.parse(_controllerCantity.text),
                              type: typeSelected,
                              title: _controllerTitle.text,
                              dateTime: DateTime.now(),//DateTime(2020, 2, 19, DateTime.now().hour, DateTime.now().minute),
                              income: isSwitched
                          )
                      );
                      Navigator.pop(context);
                    },
                    color: isSwitched ? Colors.greenAccent : Colors.redAccent,
                    text: isSwitched ? "INCOME" : "SPENT",
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value){
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeColor: Colors.greenAccent,
                    //activeTrackColor: Colors.black12,
                  )
                ],
              )
            ],
          )
      ),
    );
  }


}
import 'package:flutter/material.dart';
import 'package:my_week/Balance/model/movement.dart';
import 'package:my_week/Balance/ui/widgets/movements/item_icon.dart';
import 'package:my_week/Balance/ui/widgets/movements/item_info.dart';
import 'package:my_week/utils.dart';

class ItemDetail extends StatelessWidget{


  final Movement detail;

  ItemDetail({Key key, @required this.detail});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: EdgeInsets.only(
        left: 45,
        right: 20,
        top: 20,
      ),
      child: Row(
        children: <Widget>[
          ItemIcon(
            icon: Utils.ICON_DATA_MAP[detail.type],
          ),
          ItemInfo(detail),
          Text(
            "\$ ",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black26
            ),
          ),
          Text(
            "${detail.cantity} ",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: detail.income ? Colors.green : Colors.redAccent
            ),
          )
        ],
      ),
    );

  }

}
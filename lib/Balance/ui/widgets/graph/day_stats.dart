import 'package:flutter/material.dart';
import 'package:my_week/Balance/ui/widgets/graph/line_stat.dart';

class DayStat extends StatelessWidget{

  final String day;
  final int income;
  final int spent;
  final int total;
  bool today = false;

  DayStat({Key key, @required this.day, @required this.income, @required this.spent, @required this.total, this.today});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double spentHeight;
    double incomeHeight;
    double restHeight;

    if(total >= income && total >= spent){
      spentHeight = 180 * spent / (total + income + spent);
      incomeHeight = 180 * income / (total + income + spent);
      restHeight = 180.0 - spentHeight - incomeHeight;
    }else if(income >= total && income >= spent){
      restHeight = 180 * total / (total + income + spent);
      spentHeight = 180 * spent / (total + income + spent);
      incomeHeight = 180.0 - spentHeight - restHeight;
    } else {
      restHeight = 180 * total / (total + income + spent);
      incomeHeight = 180 * income / (total + income + spent);
      spentHeight = 180.0 - restHeight - incomeHeight;
    }

    if(incomeHeight == 0 && spentHeight > 0 && restHeight > 0){
      restHeight = restHeight + 6;
      spentHeight = spentHeight + 6;
    }

    if(spentHeight == 0 && incomeHeight > 0 && restHeight > 0){
      restHeight = restHeight + 6;
      incomeHeight = incomeHeight + 6;
    }

    return Container(
      child: Column(
        children: <Widget>[
          LineStat(
            height: restHeight,
          ),
          LineStat(
              height: spentHeight,
              color: Colors.redAccent
          ),
          LineStat(
            height: incomeHeight,
            color: Colors.greenAccent,
          ),
          Container(
            child: Text(
              day,
              style: TextStyle(
                  color: today ? Colors.greenAccent : Color.fromRGBO(255, 255, 255, 0.2),
                  fontWeight: FontWeight.bold
              ),
            ),
            margin: EdgeInsets.only(top: 15),
          )
        ],
      ),
      margin: EdgeInsets.only(
          right: 18,
          left: 18
      ),
    );
  }

}
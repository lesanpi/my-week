import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:my_week/Balance/bloc/bloc_user.dart';
import 'package:my_week/Balance/model/user.dart';
import 'package:my_week/Balance/ui/widgets/graph/day_stats.dart';
import 'package:my_week/Balance/ui/widgets/graph/financial_status.dart';
import 'package:my_week/utils.dart';

// ignore: must_be_immutable
class IncomeSpent extends StatelessWidget{

  final User user;
  UserBloc userBloc;

  IncomeSpent({Key key, @required this.user});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of<UserBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: 460,
      margin: EdgeInsets.only(
        top: 50
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.05),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60), topRight: Radius.circular(60)
        )
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 35,
          left: 40,
          right: 40,
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                "Today "
                    "${DateTime.now().day}, "
                    "${Utils.MONTHS[DateTime.now().month - 1]} "
                    "${DateTime.now().year}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w300
                ),
              ),
              margin: EdgeInsets.only(
                  bottom: 15
              ),
            ),
            StreamBuilder(
              stream: userBloc.userSpentsIncome(user, DateTime.now()),
              builder: (context, AsyncSnapshot snapshot){
                switch(snapshot.connectionState){

                  case ConnectionState.waiting:
                    return Row(
                      children: <Widget>[
                        Container(
                          child: FinancialStatus(
                              title: "Income",
                              cantity: 0
                          ),
                          margin: EdgeInsets.only(right: 55),
                        ),
                        Container(
                          child: FinancialStatus(
                              title: "Spent",
                              cantity: 0
                          ),
                          margin: EdgeInsets.only(left: 55),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    );

                  case ConnectionState.done:
                    return graphIncomeSpent(snapshot);

                  case ConnectionState.active:

                    return graphIncomeSpent(snapshot);

                  case ConnectionState.none:
                    return Row(
                      children: <Widget>[
                        Container(
                          child: FinancialStatus(
                              title: "Income",
                              cantity: 0
                          ),
                          margin: EdgeInsets.only(right: 55),
                        ),
                        Container(
                          child: FinancialStatus(
                              title: "Spent",
                              cantity: 0
                          ),
                          margin: EdgeInsets.only(left: 55),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    );

                  default:
                    return graphIncomeSpent(snapshot);
                }
              },
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  dayStat(Utils.yesterday_for(DateTime.now(), 6)),
                  dayStat(Utils.yesterday_for(DateTime.now(), 5)),
                  dayStat(Utils.yesterday_for(DateTime.now(), 4)),
                  dayStat(Utils.yesterday_for(DateTime.now(), 3)),
                  dayStat(Utils.yesterday_for(DateTime.now(), 2)),
                  dayStat(Utils.yesterday(DateTime.now())),
                  dayStat(DateTime.now()),

                ],
              ),
              margin: EdgeInsets.only(top: 20),
            )

          ],
        )
      )
    );
  }

  Widget dayStat(DateTime date){

    return StreamBuilder(
      stream: userBloc.userSpentsIncome(user, date),
      builder: (context, AsyncSnapshot snapshot){

        switch(snapshot.connectionState){

          case ConnectionState.waiting:
            return DayStat(
              day: Utils.WEEKDAYS_LETTER[date.weekday - 1],
              income: 0,
              spent: 0,
              total: 240,
              today: (date.weekday == DateTime.now().weekday)
            );

          case ConnectionState.done:
            //return Container();
            List<int> incomeSpents = userBloc.returnIncomesSpents(snapshot.data.documents);
            return DayStat(
              day: Utils.WEEKDAYS_LETTER[date.weekday - 1],
              income: incomeSpents[0],
              spent: incomeSpents[1],
              total: 240,
              today: (date.weekday == DateTime.now().weekday)
            );

          case ConnectionState.active:
            List<int> incomeSpents = userBloc.returnIncomesSpents(snapshot.data.documents);
            /*print(date.toString());
            print(incomeSpents[0]);
            print(incomeSpents[1]);*/
           return DayStat(
              day: Utils.WEEKDAYS_LETTER[date.weekday - 1],
              income: incomeSpents[0],
              spent: incomeSpents[1],
              total: 240,
             today: (date.weekday == DateTime.now().weekday)
            );

          case ConnectionState.none:
            return DayStat(
              day: Utils.WEEKDAYS_LETTER[date.weekday - 1],
              income: 0,
              spent: 0,
              total: 240,
              today:(date.weekday == DateTime.now().weekday)
            );

          default:
            //return Container();
            List<int> incomeSpents = userBloc.returnIncomesSpents(snapshot.data.documents);

            return DayStat(
              day: Utils.WEEKDAYS_LETTER[date.weekday - 1],
              income: incomeSpents[0],
              spent: incomeSpents[1],
              total: 240,
              today: (date.weekday == DateTime.now().weekday)
            );
        }


      },
    );

  }

  Widget graphIncomeSpent(AsyncSnapshot snapshot){

    List<int> incomeSpents = userBloc.returnIncomesSpents(snapshot.data.documents);

    return Row(
      children: <Widget>[
        Container(
          child: FinancialStatus(
              title: "Income",
              cantity: incomeSpents[0]
          ),
          margin: EdgeInsets.only(right: 55),
        ),
        Container(
          child: FinancialStatus(
              title: "Spent",
              cantity: incomeSpents[1]
          ),
          margin: EdgeInsets.only(left: 55),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );

  }

}


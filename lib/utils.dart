import 'package:flutter/material.dart';

class Utils{
  static Map<String, IconData> ICON_DATA_MAP = {
    "car": Icons.directions_car,
    "shopping": Icons.shopping_cart,
    "tv": Icons.live_tv
  };

  static List<String> ICON_DATA_STRING = [
    "car",
    "shopping",
    "tv"
  ];

  static List<String> MONTHS = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "November",
    "December"
  ];

  static List<String> WEEKDAYS_LETTER = [
    "M",
    "T",
    "W",
    "T",
    "F",
    "S",
    "S"
  ];

  static DateTime yesterday(DateTime date){
    int day = date.day;
    int month = date.month;
    int year = date.year;
    int yesterdayDay;
    int yesterdayMonth;
    int yesterdayYear;

    yesterdayDay = day - 1;
    if(yesterdayDay == 0){
      yesterdayMonth = month - 1;
      if(yesterdayMonth == 0){
        yesterdayMonth = 12;
        yesterdayYear = year - 1;
      }
      if(yesterdayMonth == 1 || yesterdayMonth == 3 || yesterdayMonth == 5 || yesterdayMonth == 7 || yesterdayMonth == 8 || yesterdayMonth == 10 || yesterdayMonth == 12){
        yesterdayDay = 31;
      } else if (yesterdayMonth == 2){
        if(yesterdayDay % 4 == 0) yesterdayDay = 29;
        else yesterdayDay = 28;
      } else yesterdayDay = 30;

    }else{
      yesterdayMonth = month;
      yesterdayYear = year;
    }

    DateTime yesterday = DateTime(yesterdayYear, yesterdayMonth, yesterdayDay);
    return yesterday;


  }

  static DateTime yesterday_for(DateTime date, int cant){

    int i = cant;
    DateTime day = date;
    while(i > 0){
      day = yesterday(day);
      i--;
    }

    return day;

  }

}
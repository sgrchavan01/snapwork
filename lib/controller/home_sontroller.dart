import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:snapwork/utils/date_utils.dart' as date_util;

class HomeScreenController extends GetxController {
  bool loading = false;
  String selectedYear = 'Select Year';
  String selectedMonth = 'Select Month';
  int selectMonthno = 0;
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descpController = TextEditingController();

  List<String> yearArray = [
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026"
  ];

  List<String> monthArray = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  List<int> monthIntArray = [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12];

  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();

  void toggleLoading() {
    if (loading) {
      loading = false;
    } else {
      loading = true;
    }
    update();
  }

  @override
  Future<void> onInit() async {

  }

  buildDateArray() {
    print(currentDateTime);
    String month=selectMonthno.toString().length==1?'0${selectMonthno}':'${selectMonthno.toString()}';
    String date="$selectedYear-$month-01";
    currentMonthList = date_util.DateUtils.daysInMonth(DateTime.parse(date));
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
  }
}

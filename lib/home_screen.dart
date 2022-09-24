import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapwork/controller/home_sontroller.dart';
import 'package:snapwork/eventdetails_screen.dart';
import 'package:snapwork/utils/date_utils.dart' as date_util;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final homeCtrl = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Event",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    _bottomSheetMore(context, 1);
                  },
                  child: Text(
                    homeCtrl.selectedYear,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    _bottomSheetMore(context, 2);
                  },
                  child: Text(homeCtrl.selectedMonth,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if (homeCtrl.selectedYear != "Select Year" &&
                homeCtrl.selectedMonth != "Select Month" &&
                homeCtrl.currentMonthList.length != 0)
              Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            String date =
                                '${homeCtrl.currentMonthList[index].day.toString()}-${homeCtrl.selectedMonth}-${homeCtrl.selectedYear}';
                            Get.to(EventDetailsScreen(date));
                          },
                          child: listChild(index),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          Divider(height: 1, color: Colors.grey),
                      itemCount: homeCtrl.currentMonthList.length)),
          ],
        ),
      ),
    ));
  }

  listChild(int index) {
    return Container(
      margin: EdgeInsets.all(10),
      child: IntrinsicHeight(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    homeCtrl.currentMonthList[index].day.toString(),
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    date_util.DateUtils
                        .weekdays[homeCtrl.currentMonthList[index].weekday - 1],
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ],
              )),
          VerticalDivider(
            color: Colors.grey,
            thickness: 1,
          ),
          Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ],
              )),
        ],
      )),
    );
  }

  void _bottomSheetMore(context, int selected) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: new Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text("Select Year",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selected == 1) {
                                homeCtrl.selectedYear =
                                    homeCtrl.yearArray[index];
                              } else {
                                homeCtrl.selectedMonth =
                                    homeCtrl.monthArray[index];
                                homeCtrl.selectMonthno =
                                    homeCtrl.monthIntArray[index];
                              }
                              if (homeCtrl.selectedYear != "Select Year" &&
                                  homeCtrl.selectedMonth != "Select Month") {
                                homeCtrl.buildDateArray();
                              }
                              Get.back();
                            });
                          },
                          child: ListTile(
                            title: Text(
                              selected == 1
                                  ? homeCtrl.yearArray[index]
                                  : homeCtrl.monthArray[index],
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          Divider(height: 1, color: Colors.grey),
                      itemCount: selected == 1
                          ? homeCtrl.yearArray.length
                          : homeCtrl.monthArray.length))
            ],
          ),
        );
      },
    );
  }
}

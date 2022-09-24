import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:snapwork/Model/event_model.dart';
import 'package:snapwork/dbController/DatabaseHelper.dart';

import 'controller/home_sontroller.dart';

class EventDetailsScreen extends StatefulWidget {
  String dateString;
  EventDetailsScreen(this.dateString);
  @override
  State<StatefulWidget> createState() {
    return _EventDetailsScreenState();
  }
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final homeCtrl = Get.put(HomeScreenController());
  DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Event Details",
                style: TextStyle(color: Colors.white),
              ),
            ),
            bottomNavigationBar: GestureDetector(
              child: Container(
                  height: 50,
                  width: 325,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (homeCtrl.timeController.text.isEmpty) {
                          Get.snackbar(
                            "Select time for event",
                            "",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (homeCtrl.titleController.text.isEmpty) {
                          Get.snackbar(
                            "Enter Title",
                            "",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (homeCtrl.descpController.text.isEmpty) {
                          Get.snackbar(
                            "Enter Description",
                            "",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else {
                          // Todo todo = Todo(
                          //     homeCtrl.titleController.text,
                          //     DateFormat.yMMMd().format(DateTime.now()),
                          //     homeCtrl.descpController.text);
                          // int? result; // Case 2: Insert Operation
                          // result = await helper.insertTodo(todo);
                          //
                          // if (result != 0) {
                          //   // Success
                          //   Get.snackbar('Status', 'Todo Saved Successfully');
                          // } else {
                          //   // Failure
                          //   Get.snackbar('Status', 'Problem Saving Todo');
                          // }
                          //Get.snackbar('Status', 'Todo Saved Successfully',snackPosition: SnackPosition.BOTTOM,);
                          Get.back();
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ))),
            ),
            body: Container(
              margin: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            "Date & Time :",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: timeField(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            widget.dateString,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                            "Title :",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 7,
                        child: titleField(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description :",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      descp(),
                    ],
                  )
                ],
              ),
            )));
  }

  Widget timeField() {
    return TextFormField(
      controller: homeCtrl.timeController,
      decoration: buildInputDecoration1("HH:MM", "HH:MM"),
      readOnly: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );

        if (pickedTime != null) {
          print(pickedTime.format(context));
          DateTime parsedTime =
              DateFormat.jm().parse(pickedTime.format(context).toString());
          print(parsedTime);
          String formattedTime = DateFormat('HH:mm').format(parsedTime);
          setState(() {
            homeCtrl.timeController.text = formattedTime;
          });
        } else {
          print("Time is not selected");
        }
      },
    );
  }

  Widget titleField() {
    return TextFormField(
      controller: homeCtrl.titleController,
      decoration: buildInputDecoration1("", ""),
    );
  }

  Widget descp() {
    return TextFormField(
      controller: homeCtrl.descpController,
      decoration: buildInputDecoration1("", ""),
    );
  }

  Widget buildTextField1(
      String labalText,
      String hintText,
      FormFieldValidator validator,
      Key key,
      TextEditingController controller,
      TextInputType txtinputType,
      TextCapitalization textCapitalization,
      int txtSize,
      bool enablebool) {
    return Container(
      child: Form(
        key: key,
        child: TextFormField(
          enabled: enablebool,
          maxLength: txtSize,
          textCapitalization: textCapitalization,
          controller: controller,
          autofocus: false,
          onChanged: (value) {
            setState(() {});
          },
          validator: validator,
          keyboardType: txtinputType,
          textInputAction: TextInputAction.next,
          decoration: buildInputDecoration1(labalText, hintText),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration1(String labelText, String hintText) {
    return InputDecoration(
        counter: SizedBox.shrink(),
        filled: true,
        fillColor: Color(0xffF7F8F8),
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(),
        hintText: hintText,
        errorMaxLines: 3);
  }
}

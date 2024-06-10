import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:savingmoney/controllers/mission_controller.dart';
import 'package:savingmoney/controllers/category_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/category_model.dart';
import '../themes/theme.dart';

class MissionFormWidget extends StatefulWidget {
  const MissionFormWidget({super.key});

  @override
  State<MissionFormWidget> createState() => _MissionFormWidgetState();
}

class _MissionFormWidgetState extends State<MissionFormWidget> {
  final missionC = Get.put(MissionController());
  final categoryC = Get.put(CategoryController());

  CategoryModel? selectedCategory;
  DateTime today = DateTime.now();
  DateTime? selectedTargetDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    super.initState();
    selectedTargetDate = null;
    selectedCategory = null;
  }

  void _onStartDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedTargetDate = day;
    });
  }

  void _onEndDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedEndDate = day;
    });
  }

  bool isBeforeToday(DateTime day) {
    final DateTime now = DateTime.now();
    return day.isBefore(DateTime(now.year, now.month, now.day));
  }

  Future<void> _showCalendarModal(BuildContext context) async {
    final DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: TableCalendar(
            focusedDay: today,
            locale: "en_US",
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime(2024, 12 + 1, 0),
            calendarFormat: CalendarFormat.month,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            availableGestures: AvailableGestures.all,
            onDaySelected: (day, focusedDay) {
              Navigator.pop(context, day);
              _onStartDaySelected(day, focusedDay);
            },
            selectedDayPredicate: (day) => isSameDay(day, selectedTargetDate),
            enabledDayPredicate: (day) => !isBeforeToday(day),
            calendarStyle: const CalendarStyle(
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Color(0xffC6C2C2),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color(0xff12486B),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedTargetDate = pickedDate;
        missionC.targetDate.text =
            DateFormat('yyyy-MM-dd').format(selectedTargetDate!);
        print('Selected Start Date: ${missionC.targetDate.text}');
      });
    }
  }

  void _submitMission() async {
    if (selectedCategory == null) {
      Get.snackbar(
        "Error",
        "Please Input The Data!",
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      await missionC.addMission(
        title: missionC.title.text,
        targetAmount: missionC.amount.text,
        targetDate: missionC.targetDate.text,
        categoryId: missionC.categoryId.text,
        // description: missionC.description.text,
      );
    } catch (e) {
      print('Error submitting mission: $e');
      Get.snackbar(
        "Error",
        "An error occurred while submitting the mission.",
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: blackTextStyle.copyWith(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: TextField(
                controller: missionC.title,
                style: blackTextStyle.copyWith(
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintStyle: subTextStyle.copyWith(
                    fontSize: 13,
                  ),
                  hintText: 'title...',
                  iconColor: Color(0xff8D92A3),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Target Amount",
              style: blackTextStyle.copyWith(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: TextField(
                controller: missionC.amount,
                style: blackTextStyle.copyWith(
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintStyle: subTextStyle.copyWith(
                    fontSize: 13,
                  ),
                  hintText: 'Amount...',
                  iconColor: Color(0xff8D92A3),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Target Mission",
              style: blackTextStyle.copyWith(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                _showCalendarModal(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: baseColor,
                  ),
                  borderRadius: BorderRadius.circular(100),
                  color: whiteColor,
                ),
                padding: const EdgeInsets.only(
                    // left: 20,
                    ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: TextField(
                        controller: missionC.targetDate,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: selectedTargetDate != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(selectedTargetDate!)
                              : 'Select Start Date',
                          border: InputBorder.none,
                          hintStyle: subTextStyle.copyWith(
                            fontSize: 13,
                          ),
                        ),
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showCalendarModal(context);
                      },
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        size: 24,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Category",
              style: blackTextStyle.copyWith(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Obx(() {
                  if (categoryC.isLoading == true) {
                    return CircularProgressIndicator();
                  } else if (categoryC.categoryList.isEmpty) {
                    return Text(
                      'No categories available',
                      style: subTextStyle.copyWith(
                        fontSize: 13,
                      ),
                    );
                  } else {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<CategoryModel>(
                        hint: Text(
                          'Select Category...',
                          style: subTextStyle.copyWith(
                            fontSize: 13,
                          ),
                        ),
                        value: selectedCategory,
                        isExpanded: true,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: blackColor,
                        ),
                        style: blackTextStyle.copyWith(
                          fontSize: 13,
                        ),
                        onChanged: (CategoryModel? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                            missionC.categoryId.text = newValue!.id.toString();
                          });
                        },
                        items: categoryC.categoryList
                            .map((CategoryModel category) {
                          return DropdownMenuItem<CategoryModel>(
                            value: category,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Text(
                                category.name,
                                style: blackTextStyle.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Text(
            //   "Information",
            //   style: blackTextStyle.copyWith(
            //     fontSize: 15,
            //   ),
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: const EdgeInsets.symmetric(
            //     vertical: 4,
            //   ),
            //   decoration: BoxDecoration(
            //     color: whiteColor,
            //     borderRadius: BorderRadius.circular(100),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.shade300,
            //         blurRadius: 2,
            //         offset: const Offset(0, 0),
            //       ),
            //     ],
            //   ),
            //   child: TextField(
            //     controller: missionC.description,
            //     maxLines: null,
            //     keyboardType: TextInputType.multiline,
            //     style: blackTextStyle.copyWith(
            //       fontSize: 13,
            //     ),
            //     decoration: InputDecoration(
            //       hintStyle: subTextStyle.copyWith(
            //         fontSize: 13,
            //       ),
            //       hintText: 'Information...',
            //       iconColor: Color(0xff8D92A3),
            //       border: InputBorder.none,
            //       contentPadding: EdgeInsets.all(15),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            InkWell(
              onTap: _submitMission,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: whiteTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

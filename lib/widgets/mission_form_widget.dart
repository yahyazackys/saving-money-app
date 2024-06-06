import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:savingmoney/controllers/saving_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import '../themes/theme.dart';

class MissionFormWidget extends StatefulWidget {
  const MissionFormWidget({super.key});

  @override
  State<MissionFormWidget> createState() => _MissionFormWidgetState();
}

class _MissionFormWidgetState extends State<MissionFormWidget> {
  final SavingController taskC = Get.put(SavingController());

  String? selectedValue;
  final List<String> categories = ['Option 1', 'Option 2', 'Option 3'];
  DateTime today = DateTime.now();
  DateTime? selectedTargetDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    super.initState();
    selectedTargetDate = null;
    selectedEndDate = null;
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
        // Menggunakan format yang diharapkan oleh sistem (YYYY-MM-DD)
        taskC.targetDate.text =
            DateFormat('yyyy-MM-dd').format(selectedTargetDate!);
        print('Selected Start Date: ${taskC.targetDate.text}');
      });
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
              "Amount",
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
                // controller: taskC.title,
                style: subTextStyle.copyWith(
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
                  left: 20,
                  // right: 40,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: TextField(
                        // controller: taskC.startDate,
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(
                      'Category...',
                      style: subTextStyle.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    value: selectedValue,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: blackColor,
                    ),
                    style: blackTextStyle.copyWith(
                      fontSize: 13,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                    items: categories.map(
                      (String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Text(
                              option,
                              style: subTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Description",
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
                // controller: taskC.description,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: subTextStyle.copyWith(
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintStyle: subTextStyle.copyWith(
                    fontSize: 13,
                  ),
                  hintText: 'Description',
                  iconColor: Color(0xff8D92A3),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: null,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savingmoney/controllers/category_controller.dart';
import 'package:savingmoney/controllers/mission_controller.dart';
import 'package:savingmoney/controllers/transaction_controller.dart';
import 'package:savingmoney/pages/History.dart';
import 'package:savingmoney/themes/theme.dart';

import 'notification_helper.dart';
import 'pages/LandingPage.dart';
import 'pages/Profile.dart';

class Home extends StatefulWidget {
  final Widget initialScreen;
  final int onTabChanged;
  const Home(
      {Key? key, required this.initialScreen, required this.onTabChanged})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _categoryC = Get.put(CategoryController());
  final _missionC = Get.put(MissionController());
  final _transactionC = Get.put(TransactionController());
  final NotificationHelper notifyHelper = NotificationHelper();

  late Widget currentScreen;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    currentScreen = widget.initialScreen;
    currentTab = widget.onTabChanged;
    initializeData();
  }

  void initializeData() async {
    await _categoryC.fetchCategories();
    await _missionC.fetchMissions();
    await _transactionC.fetchIncomes();
    await _transactionC.fetchSpendings();
    await notifyHelper.scheduledNotification();
    setState(() {}); // Update UI after data is fetched
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        currentScreen,
        Positioned(
          left: 30,
          right: 30,
          bottom: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Home
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const Landingpage();
                        currentTab = 0;
                      });
                    },
                    icon: Icon(
                      Icons.home,
                      size: 30,
                      color: currentTab == 0
                          ? whiteColor
                          : const Color.fromARGB(255, 168, 173, 195),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const History();
                        currentTab = 1;
                      });
                    },
                    icon: Icon(
                      Icons.history_outlined,
                      size: 30,
                      color: currentTab == 1
                          ? whiteColor
                          : const Color.fromARGB(255, 168, 173, 195),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const Profile();
                        currentTab = 2;
                      });
                    },
                    icon: Icon(
                      Icons.person_3_rounded,
                      size: 30,
                      color: currentTab == 2
                          ? whiteColor
                          : const Color.fromARGB(255, 168, 173, 195),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

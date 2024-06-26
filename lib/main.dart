import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savingmoney/notification_helper.dart';
import 'package:savingmoney/pages/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notifyHelper = NotificationHelper();
  // var notifyHelper;
  // notifyHelper = NotificationHelper();
  notifyHelper.initializeNotification();
  notifyHelper.requestIOSPermissions();
  notifyHelper.scheduledNotification();
  // await Get.putAsync(() => SpUtil.getInstance());
  // final NotificationHelper notificationHelper = NotificationHelper();
  // notificationHelper.checkMissionDates();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Splash(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

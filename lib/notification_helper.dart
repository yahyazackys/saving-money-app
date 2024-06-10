import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:savingmoney/themes/theme.dart';
import 'package:sp_util/sp_util.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'controllers/mission_controller.dart';

class NotificationHelper {
  final missionC = Get.put(MissionController());
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    tz.initializeTimeZones();
    final location = tz.getLocation('Asia/Kuala_Lumpur');
    tz.setLocalLocation(location);
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("logo");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  scheduleNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'theme changes 5 seconds ago',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
        )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  scheduledNotification() async {
    final now = DateTime.now();
    print(missionC.missionList.length);

    for (var mission in missionC.missionList) {
      final targetDate = DateFormat('yyyy-MM-dd').parse(mission.targetDate);
      final reminderDate = targetDate.subtract(const Duration(days: 1));

      // Waktu pengiriman notifikasi adalah jam 2 siang pada reminderDate
      final scheduledTime = tz.TZDateTime.from(
        reminderDate.add(
          const Duration(
            hours: 18,
            minutes: 04,
          ),
        ),
        tz.local,
      );

      if (scheduledTime.isAfter(now)) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          'Reminder',
          'Your mission "${mission.title}" is due tomorrow!',
          scheduledTime,
          const NotificationDetails(
              android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
          )),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
        print("Notification scheduled for ${mission.title} at $scheduledTime");
      } else {
        print(
            "Scheduled time $scheduledTime is in the past, not scheduling notification.");
      }
    }
  }

  checkMissionDates() async {
    final now = DateTime.now();

    for (var mission in missionC.missionList) {
      final targetDate = DateFormat('yyyy-MM-dd').parse(mission.targetDate);
      final reminderDate = targetDate.subtract(const Duration(days: 1));

      // if (reminderDate.isAfter(now)) {
      final scheduledTime = tz.TZDateTime.from(
        reminderDate.add(
          const Duration(
            hours: 17,
            minutes: 14,
          ),
        ), // Misalnya notifikasi jam 8 pagi
        tz.local,
      );

      // await scheduledNotification(
      //   scheduledTime,
      //   'Reminder',
      //   'Your mission "${mission.title}" is due tomorrow!',
      // );
      // }
    }
  }

  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      sound: 'notification_sound.caf',
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound ',
    );
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(() => Container(
          color: whiteColor,
        ));
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    Get.dialog(Text("Welcome to Saving Money"));
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   //context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }
}

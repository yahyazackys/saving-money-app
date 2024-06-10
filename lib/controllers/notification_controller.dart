// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:sp_util/sp_util.dart';
// import 'package:url_launcher/url_launcher.dart';

// class NotificationManager {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Inisialisasi plugin notifikasi
//   Future<void> initialize() async {
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   // Buat dan tampilkan notifikasi
//   Future<void> showNotification(String title, String body) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0, // id notifikasi, harus unik untuk setiap notifikasi
//       title,
//       body,
//       platformChannelSpecifics,
//     );
//   }

//   // Kirim pesan WhatsApp
//   Future<void> sendWhatsAppMessage() async {
//     String nohp = SpUtil.getString("nohp_user") ?? "";
//     final url =
//         'https://wa.me/$nohp?text=Reminder: Your mission "${mission.title}" is due tomorrow!';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }

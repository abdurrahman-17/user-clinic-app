import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:user_clinic_token_app/utils/common/app_route_paths.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(context) {
    final InitializationSettings initializationSettings =
    InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (message)async{
      if(message!=null){
        print(message);
        Navigator.of(context).pushNamed(RoutePaths.Notification_New);
      }
    });
  }

  static void display(RemoteMessage message) async {
    try{
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails("irfan",
              "irfan channel",
              channelDescription: 'high',
              importance: Importance.max,
              priority: Priority.high));
      await flutterLocalNotificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,payload: message.data["route"]);
    }on Exception catch (e){
      print(e);
    }
  }
}

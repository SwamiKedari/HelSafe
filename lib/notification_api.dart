import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class notifications{
  static final _notifications=FlutterLocalNotificationsPlugin();
  static Future _notificationDetails() async{
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name' ),
      iOS: DarwinNotificationDetails() ,
    );
  }
  static Future showNotifications({int id=0, String? title, String? body,String? payload,} ) async=> _notifications.show(id,title,body,await _notificationDetails() ,payload: payload);
}

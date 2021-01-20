import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

import 'time_zone_helper.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();
final selectNotificationSubject = BehaviorSubject<String>();

class LocalNotificationUtils {
  /// Inicializa as configuracoes para iniciar
  static Future<void> initializeSettings() async {
    await TimeZoneHelper.configureLocalTimeZone();

    //final notificationAppLaunchDetails =  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuracoes em iOS
    final initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        });

    // Configuracoes MacOS
    const initializationSettingsMacOS = MacOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);

    // Configuracoes de inicializacao
    final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);

    // Plugin de Local Notification
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      selectNotificationSubject.add(payload);
    });
  }

  /// Agenda uma notificacao com um timer dado
  static Future<void> scheduleTimedNotification(
      {int id, String title, String body, Duration duration}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        TimeZoneHelper.nowPlusDuration(duration: duration),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  /// Agenda uma notificacao para a proxima vez que uma hora ocorrer
  static Future<void> scheduleDailyNotificationForNextTime(
      {int id, String title, String body, int hour, int minute}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        TimeZoneHelper.nextInstanceOf(hour: hour, minute: minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily notification channel id',
              'daily notification channel name',
              'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static Future<void> scheduleNotificationForDay(
      {int id,
      String title,
      String body,
      int day,
      int hour,
      int minute}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        TimeZoneHelper.nextInstanceOfDay(day: day, hour: hour, minute: minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'weekly notification channel id',
              'weekly notification channel name',
              'weekly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  /// Mostra diretamente uma notificacao
  static Future<void> showNotification({String title, String body}) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'item x');
  }

  /// Remove a notificacao de via [id].
  Future<void> cancelNotification({int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

/// Modelo de uma notificacao recebida.
class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

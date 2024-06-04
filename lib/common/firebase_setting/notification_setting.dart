import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'global_variable.dart';

final notificationProvider = Provider<NotificationManager>((ref) {
  final plugin = FlutterLocalNotificationsPlugin();
  return NotificationManager(plugin);
});

class NotificationManager {
  late AndroidNotificationChannel channel;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isFlutterLocalNotificationsInitialized = false;

  NotificationManager(
    this.flutterLocalNotificationsPlugin,
  );

  Future<void> initFlutterLocalNotificationsPlugin() async {
    if (!isFlutterLocalNotificationsInitialized) {
      var initialzationSettingsAndroid =
          const AndroidInitializationSettings('@mipmap/ic_launcher');

      var initialzationSettingsIOS = const DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );
      var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid,
        iOS: initialzationSettingsIOS,
      );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
          if (GlobalVariable.naviagatorState.currentContext != null) {
            // Navigator.of(GlobalVariable.naviagatorState.currentContext!).push(
            //   MaterialPageRoute(
            //     builder: (context) => const NotiView(),
            //   ),
            // );
          }
        },
      );
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.',
        // description
        importance: Importance.high,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  Future<String?> getToken(FirebaseMessaging instance) async {
    if (!isFlutterLocalNotificationsInitialized) {
      String? fcmToken = await instance.getToken();
      print('fcmToken : ${fcmToken ?? 'token NULL!'}');
      isFlutterLocalNotificationsInitialized = true;
      return fcmToken;
    }
    return null;
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    if (notification != null && android != null && Platform.isAndroid) {
      // 웹, ios가 아니면서 안드로이드이고, 알림이 있는경우
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
          ),
        ),
      );
    }

    if (notification != null && apple != null && Platform.isIOS) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          iOS: DarwinNotificationDetails(
            sound: 'default',
            badgeNumber: 1,
          ),
        ),
      );
    }
  }

  @pragma('vm:entry-point')
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if (GlobalVariable.naviagatorState.currentContext != null) {
      // Navigator.of(GlobalVariable.naviagatorState.currentContext!).push(
      //   // MaterialPageRoute(
      //   //   builder: (context) => const NotiView(),
      //   // ),
      // );
    }
  }

  void getPermission(FirebaseMessaging instance) async {
    await instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    NotificationSettings settings = await instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}

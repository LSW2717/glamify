import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:glamify/common/data_source/data.dart';
import 'package:glamify/common/secure_storage/secure_storage.dart';

import 'global_variable.dart';
import 'notification_setting.dart';

final fcmProvider = Provider<FcmManager>((ref) {
  final notificationManager = ref.watch(notificationProvider);
  final storage = ref.watch(secureStorageProvider);
  return FcmManager(notificationManager, storage);
});

class FcmManager {
  final NotificationManager notificationManager;
  final FlutterSecureStorage storage;
  late String? fcmToken;

  FcmManager(
    this.notificationManager,
    this.storage,
  ) {
    tokenInit();
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    print(message);
    // ref.read(userMeProvider.notifier).getMe();
    if (notification != null && android != null && Platform.isAndroid) {
      notificationManager.flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            notificationManager.channel.id,
            notificationManager.channel.name,
            channelDescription: notificationManager.channel.description,
          ),
        ),
      );
    }
    if (notification != null && apple != null && Platform.isIOS) {
      notificationManager.flutterLocalNotificationsPlugin.show(
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

  void tokenInit() async {
    notificationManager.initFlutterLocalNotificationsPlugin();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    notificationManager.getPermission(_firebaseMessaging);
    getFcmToken(_firebaseMessaging);
    FirebaseMessaging.onBackgroundMessage(
        notificationManager.firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        if (message.notification != null) {
          print('in background / terminated');
          print(message.notification!.title);
          print(message.notification!.body);
        }
      }
    });
  }

  Future<void> getFcmToken(FirebaseMessaging instance) async {
    fcmToken = await notificationManager.getToken(instance);
    print('토큰 저장됨');
    await storage.write(key: FCM_TOKEN_KEY, value: fcmToken);
    if (fcmToken != null) {
      updateFcmToken(fcmToken!);
    }
  }

  Future<void> updateFcmToken(String fbFcmToken) async {
    final int createdTime =
        ((DateTime.now().microsecondsSinceEpoch) / 1000).round();
    final serverFcmToken = await getServerFcmToken();
    //TODO 서버와 통신해서 FCM token 저장
    // if (fcmToken != null && fcmTokenCreated != null) {
    //   if ((int.parse(fcmTokenCreated) + 604800) < createdTime ||
    //       fcmToken != fbFcmToken) {
    //     await fcmRepository.updateFcmToken(FcmModel(fcmToken: fbFcmToken));
    //   }
    // } else if (fbFcmToken != serverFcmToken) {
    //   await fcmRepository.updateFcmToken(FcmModel(fcmToken: fbFcmToken));
    // }
  }

  Future<void> getServerFcmToken() async {
    try {
      // final res = await fcmRepository.getFcmToken();
      // return res.fcmToken;
    } catch (e) {
      return;
    }
  }

  void _handleMessage(RemoteMessage message) {
    print(message);
    if (GlobalVariable.naviagatorState.currentContext != null) {
      // Navigator.of(GlobalVariable.naviagatorState.currentContext!).push(
      //   MaterialPageRoute(
      //     builder: (context) => const NotiView(),
      //   ),
      // );
    }
  }

  Future<void> removeBadge() async {
    if (await FlutterAppBadger.isAppBadgeSupported()) {
      FlutterAppBadger.removeBadge();
    }
  }
}

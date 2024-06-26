import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:glamify/chat/view_model/chat_list_view_model.dart';
import 'package:glamify/common/data_source/data.dart';
import 'package:glamify/common/secure_storage/secure_storage.dart';
import 'package:glamify/user/view_model/user_view_model.dart';

import 'notification_setting.dart';

final fcmProvider = Provider<FcmManager>((ref) {
  final notificationManager = ref.watch(notificationProvider);
  final storage = ref.watch(secureStorageProvider);
  return FcmManager(notificationManager, storage, ref);
});

class FcmManager {
  final NotificationManager notificationManager;
  final FlutterSecureStorage storage;
  final Ref ref;
  late String? fcmToken;

  FcmManager(
    this.notificationManager,
    this.storage,
    this.ref,
  ) {
    tokenInit();
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    print(message);
    ref.read(chatListProvider.notifier).updateChatList();
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
    // FirebaseMessaging.onBackgroundMessage(
    //     notificationManager.firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
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
    await storage.write(key: FCM_TOKEN_KEY, value: fcmToken);
    if(fcmToken != null){
      ref.read(userViewModelProvider.notifier).updateFcmToken(fcmToken!);
    }
  }

  Future<void> removeBadge() async {
    if (await FlutterAppBadger.isAppBadgeSupported()) {
      FlutterAppBadger.removeBadge();
    }
  }
}

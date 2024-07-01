import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:glamify/common/data_source/data.dart';
import 'package:glamify/common/secure_storage/secure_storage.dart';
import 'package:glamify/user/view_model/user_view_model.dart';

import '../../home/view_model/home_random_chat_view_model.dart';
import 'notification_setting.dart';

final fcmProvider = Provider<FcmManager>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return FcmManager(storage, ref);
});

class FcmManager {
  final FlutterSecureStorage storage;
  final Ref ref;
  late String? fcmToken;

  FcmManager(
    this.storage,
    this.ref,
  ) {
    tokenInit();
  }

  void tokenInit() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    getFcmToken(firebaseMessaging);
  }

  Future<void> getFcmToken(FirebaseMessaging instance) async {

    fcmToken = await getToken(instance);
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

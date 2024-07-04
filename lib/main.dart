import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/chat/view_model/chat_list_view_model.dart';
import 'package:glamify/common/firebase_setting/firebase_handler.dart';
import 'package:glamify/common/firebase_setting/notification_setting.dart';
import 'package:glamify/common/websocket/websocket.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'common/firebase_setting/firebase_options.dart';
import 'common/router/router.dart';
import 'home/view_model/home_random_chat_view_model.dart';
import 'home/view_model/toggle_button_view_model.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 세로 방향 고정
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  initFlutterLocalNotificationsPlugin();
  getPermission(FirebaseMessaging.instance);
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    ref.read(websocketProvider).connect();
    ref.read(fcmProvider).removeBadge();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await showFlutterNotification(message);
      ref.read(homeRandomChatViewModelProvider.notifier).getRandomChatInfo();
      ref.read(chatListProvider.notifier).updateChatList();
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // 알림 클릭 시 처리 로직 추가
    });
  }

  @override
  void dispose() {
    ref.read(websocketProvider).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1.0),
        ),
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          child: child,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        canvasColor: Colors.white,
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/common/websocket/websocket.dart';

import 'common/firebase_setting/firebase_options.dart';
import 'common/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 세로 방향 고정
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    ref.read(websocketProvider).connect();
    super.initState();
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

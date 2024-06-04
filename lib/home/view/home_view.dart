import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify_mobile/common/firebase_setting/firebase_handler.dart';


class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fcmProvider);
    return Center(child: Text('홈입니당'),);
  }
}

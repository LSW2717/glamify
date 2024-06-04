import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../chat/view/chat_detail_view.dart';
import '../../user/view_model/auth_view_model.dart';
import '../view/root_tab.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider);

  Page<dynamic> platformPage(Widget child, String key) {
    return Platform.isIOS
        ? CupertinoPage<void>(key: ValueKey(key), child: child)
        : MaterialPage<void>(key: ValueKey(key), child: child);
  }

  Page<dynamic> platformPageWithoutKey(Widget child) {
    return Platform.isIOS
        ? CupertinoPage<void>(child: child)
        : MaterialPage<void>(child: child);
  }

  return GoRouter(
    // initialLocation: '/splash',
    routes: [
      GoRoute(
          path: '/',
          pageBuilder: (context, state) => platformPage(const RootTab(), '/'),
          routes: [
            GoRoute(
              path: 'chatDetail',
              pageBuilder: (context, state) => platformPage(const ChatDetailView(), 'chatDetail'),
            ),
          ]),
    ],
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});

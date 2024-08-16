import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/view/chat_invite_view.dart';
import 'package:glamify/chat/view_model/chat_detail_view_model.dart';
import 'package:glamify/chat/view_model/chat_list_view_model.dart';
import 'package:glamify/chat/view_model/chat_message_view_model.dart';
import 'package:glamify/mypage/view/login_view.dart';
import 'package:glamify/mypage/view/my_page_update_nickname_view.dart';
import 'package:glamify/mypage/view/noti_setting_view.dart';
import 'package:go_router/go_router.dart';

import '../../chat/view/chat_detail_view.dart';
import '../../mypage/view/report_list_view.dart';
import '../../mypage/view/send_report_view.dart';
import '../../mypage/view/setting_view.dart';
import '../../user/model/user_model.dart';
import '../../user/view_model/auth_view_model.dart';
import '../global_variable/global_variable.dart';
import '../view/full_screen_gallery.dart';
import '../view/root_tab.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.watch(authProvider);
  Page<dynamic> platformPage(Widget child, String key) {
    return Platform.isIOS
        ? CupertinoPage<void>(key: ValueKey(key), child: child)
        : MaterialPage<void>(key: ValueKey(key), child: child);
  }

  Page<dynamic> platformPageWithoutKey(Widget child) {
    return Platform.isIOS
        ? CupertinoPage<void>(child: child, fullscreenDialog: true)
        : MaterialPage<void>(child: child, fullscreenDialog: true);
  }

  return GoRouter(
    // initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => platformPage(const RootTab(), '/'),
        routes: [
          GoRoute(
            path: 'login',
            pageBuilder: (context, state) => platformPage(const LoginView(), 'login'),
          ),
          GoRoute(
            path: 'chatDetail',
            pageBuilder: (context, state) {
              final chatRoomId = state.extra as int;
              return platformPage(
                  ChatDetailView(chatRoomId: chatRoomId), 'chatDetail');
            },
            onExit: (context) {
              ref.read(chatListProvider.notifier).updateChatList();
              ref.refresh(chatMessageViewModelProvider(0));
              return true;
            },
          ),
          GoRoute(
            path: 'chatDetail2',
            pageBuilder: (context, state) {
              final chatRoomId = state.extra as int;
              return platformPageWithoutKey(
                  ChatDetailView(chatRoomId: chatRoomId));
            },
            onExit: (context) {
              ref.read(chatListProvider.notifier).updateChatList();
              ref.refresh(chatMessageViewModelProvider(0));
              return true;
            },
          ),
          GoRoute(
            path: 'updateNickname',
            pageBuilder: (context, state) {
              final user = state.extra as UserModel;
              return platformPage(
                  UpdateNickNameView(user: user), 'updateNickname');
            },
          ),
          GoRoute(
            path: 'setting',
            pageBuilder: (context, state) {
              return platformPage(const SettingView(), 'setting');
            },
            routes: [
              GoRoute(
                path: 'notisetting',
                pageBuilder: (context, state) {
                  return platformPage(const NotiSettingView(), 'notisetting');
                },
              ),
            ],
          ),
          GoRoute(
            path: 'fullScreenGallery',
            pageBuilder: (context, state) {
              final imageUrl = state.extra as String;
              return platformPage(
                  FullScreenGallery(imageUrl: imageUrl, initialIndex: 0),
                  'fullScreenGallery');
            },
          ),
          GoRoute(
            path: 'invite',
            pageBuilder: (context, state) {
              return platformPage(const ChatInviteView(), 'invite');
            },
          ),
          GoRoute(
            path: 'report',
            pageBuilder: (context, state) {
              return platformPage(const ReportListView(), 'report');
            },
            routes: [
              GoRoute(
                path: 'sendReport',
                pageBuilder: (context, state) {
                  return platformPage(const SendReportView(), 'sendReport');
                },
              ),
            ],
          ),
        ],
      ),
    ],
    refreshListenable: provider,
    redirect: provider.redirectLogic,
    navigatorKey: GlobalVariable.naviagatorState,
  );
});

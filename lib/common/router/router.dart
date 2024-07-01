import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/model/chat_room_response_model.dart';
import 'package:glamify/chat/view/chat_invite_view.dart';
import 'package:glamify/chat/view_model/chat_detail_view_model.dart';
import 'package:glamify/chat/view_model/chat_list_view_model.dart';
import 'package:glamify/chat/view_model/chat_message_view_model.dart';
import 'package:glamify/chat/view_model/chat_room_id_view_model.dart';
import 'package:glamify/mypage/view/my_page_update_nickname_view.dart';
import 'package:go_router/go_router.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../chat/view/chat_detail_view.dart';
import '../../mypage/view/setting_view.dart';
import '../../user/view_model/auth_view_model.dart';
import '../view/root_tab.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider);

  Page<dynamic> platformPage(Widget child, String key) {
    return Platform.isIOS
        ? CupertinoPage<void>(key: ValueKey(key), child: child, fullscreenDialog: true)
        : MaterialPage<void>(key: ValueKey(key), child: child, fullscreenDialog: true);
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
            pageBuilder: (context, state) {
              final chatRoomId = state.extra as int;
              return platformPageWithoutKey(
                  ChatDetailView(chatRoomId: chatRoomId));
            },
            onExit: (context) {
              final id = ref.read(chatRoomIdViewModelProvider);
              print(id);
              ref.read(chatListProvider.notifier).updateChatList();
              ref.read(chatDetailProvider.notifier).updateMessageReadCount(id);
              ref.refresh(chatMessageProvider);
              return true;
            },
          ),
          GoRoute(
            path: 'chatDetail2',
            pageBuilder: (context, state) {
              final chatRoomId = state.extra as int;
              return platformPage(
                  ChatDetailView(chatRoomId: chatRoomId),'chatDetail2');
            },
            onExit: (context) {
              final id = ref.read(chatRoomIdViewModelProvider);
              print(id);
              ref.read(chatListProvider.notifier).updateChatList();
              ref.read(chatDetailProvider.notifier).updateMessageReadCount(id);
              ref.refresh(chatMessageProvider);
              return true;
            },
          ),
          GoRoute(
            path: 'updateNickname',
            pageBuilder: (context, state) {
              return platformPage(const UpdateNickNameView(), 'updateNickname');
            },
          ),
          GoRoute(
            path: 'setting',
            pageBuilder: (context, state) {
              return platformPage(const SettingView(), 'setting');
            },
          ),
          GoRoute(
            path: 'invite',
            pageBuilder: (context, state) {
              return platformPage(const ChatInviteView(), 'invite');
            },
          ),
        ],
      ),
    ],
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});

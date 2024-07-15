import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/chat/view_model/chat_invite_list_view_model.dart';
import 'package:glamify/chat/view_model/chat_list_view_model.dart';
import 'package:glamify/home/view_model/home_matching_button_view_model.dart';
import 'package:glamify/home/view_model/toggle_button_view_model.dart';
import 'package:glamify/user/model/user_model.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/alert_message.dart';
import '../../home/view_model/home_random_chat_view_model.dart';
import '../model/chat_room_request_model.dart';
import '../model/chat_room_response_model.dart';
import '../view_model/chat_detail_view_model.dart';

class ChatActionButton extends ConsumerWidget {
  final ChatRoomResponse chatRoom;
  final ChatRoomInfoResponse chatInfo;

  const ChatActionButton({
    required this.chatRoom,
    required this.chatInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);
    return IconButton(
      onPressed: () {
        showMenu(
          context: context,
          position: RelativeRect.fromSize(
              Rect.fromLTRB(390.w, 100.h, 0, 0), Size(390.w, 844.w)),
          color: Colors.white,
          items: [
            PopupMenuItem<int>(
                onTap: () async {
                  final bool confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlarmMessage(
                            title: '나가기',
                            content: '채팅방을 나가시겠습니까?',
                          );
                        },
                      ) ??
                      false;
                  if (confirm) {
                    ref.read(homeRandomChatViewModelProvider.notifier).refreshRandomChat();
                    ref.read(homeMatchingButtonViewModelProvider.notifier).setFalse();
                    await ref.read(chatDetailViewModelProvider(chatRoom.chatRoomId).notifier)
                        .leaveChatRoom();
                    await ref.read(chatListProvider.notifier).updateChatList();
                    context.pop();
                  }
                },
                value: 1,
                child: const Text('나가기')),
            if (chatRoom.randomYN == 'Y')
              PopupMenuItem<int>(
                onTap: () async {
                  final bool confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlarmMessage(
                            title: '친구추가하기',
                            content: '친구추가를 요청하시겠어요?',
                          );
                        },
                      ) ??
                      false;
                  if (confirm) {
                    if(userState is LoadedUserState){
                      final myUserId = userState.user.userId;
                      if(chatInfo.chatRoomUsers!.isNotEmpty){
                        final targetUser = chatInfo.chatRoomUsers!.firstWhere(
                              (user) => user.userId != myUserId,
                          orElse: () => throw Exception('No other user found'),
                        );
                        final InviteChatRequest request = InviteChatRequest(
                          targetId: targetUser.userId,
                          message: '안녕하세용',
                        );
                        await ref.read(chatInviteListProvider.notifier).inviteChat(request);
                      }
                    }
                  }
                },
                value: 2,
                child: const Text('친구추가하기'),
              ),
            PopupMenuItem<int>(
              onTap: () {},
              value: 3,
              child: const Text('신고하기'),
            ),
          ],
        );
      },
      icon: Icon(
        Icons.more_vert,
        size: 25.w,
        color: Colors.black,
      ),
    );
  }
}

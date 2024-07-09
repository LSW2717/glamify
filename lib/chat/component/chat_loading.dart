import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/common/layout/default_layout.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/alert_message.dart';
import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../home/view_model/home_random_chat_view_model.dart';
import '../view_model/chat_detail_view_model.dart';
import 'chat_bottom_bar.dart';

class ChatLoading extends ConsumerStatefulWidget {
  final int chatRoomId;
  const ChatLoading({
    required this.chatRoomId,
    super.key,
  });

  @override
  ConsumerState<ChatLoading> createState() => _ChatLoadingState();
}

class _ChatLoadingState extends ConsumerState<ChatLoading> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      needBackButton: true,
      resizeToAvoidBottomInset: true,
      backAction: () {
        context.pop();
      },
      action: [
        IconButton(
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
                        ref.read(chatDetailViewModelProvider(widget.chatRoomId).notifier)
                            .leaveChatRoom();
                        ref.read(homeRandomChatViewModelProvider.notifier).getRandomChatInfo();
                        context.pop();
                      }
                    },
                    value: 1,
                    child: const Text('나가기')),
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
        ),
      ],
      title: '',
      child: Chat(
        messages: const [],
        onSendPressed: (text) {},
        showUserAvatars: true,
        showUserNames: true,
        user: User(id: ''),
        emptyState: const Center(
            child: CircularProgressIndicator(
          color: main1,
        )),
        customBottomWidget: ChatBottomBar(
          sendPressed: (text) {},
          controller: controller,
        ),
        theme: DefaultChatTheme(
          messageBorderRadius: 10,
          messageInsetsHorizontal: 10.w,
          messageInsetsVertical: 6.w,
          primaryColor: main1,
          receivedMessageBodyTextStyle: headerText5,
          dateDividerTextStyle: bodyText2.copyWith(color: base5),
        ),
      ),
    );
  }
}

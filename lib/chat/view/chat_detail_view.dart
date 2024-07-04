import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/chat/component/chat_action_button.dart';
import 'package:glamify/chat/component/chat_error.dart';
import 'package:glamify/chat/component/chat_loading.dart';
import 'package:glamify/chat/view_model/chat_detail_view_model.dart';
import 'package:glamify/chat/view_model/chat_message_view_model.dart';
import 'package:glamify/user/model/user_model.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/layout/default_layout.dart';
import '../component/chat_bottom_bar.dart';

class ChatDetailView extends ConsumerStatefulWidget {
  final int chatRoomId;

  const ChatDetailView({
    required this.chatRoomId,
    super.key,
  });

  @override
  ConsumerState<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends ConsumerState<ChatDetailView> {
  late TextEditingController textController;
  late FocusNode focusNode;
  final GlobalKey<ChatState> _chatKey = GlobalKey();
  Timer? _throttleTimer;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    focusNode = FocusNode();
  }

  void _handleEndReached() {
    if (_throttleTimer?.isActive == true) {
      return;
    }
    if (mounted) {
      setState(() {
        ref
            .read(chatMessageViewModelProvider(widget.chatRoomId).notifier)
            .getMessageList();
        _throttleTimer = Timer(const Duration(milliseconds: 500), () {});
      });
    }
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    _throttleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatDetailProvider);
    final userState = ref.watch(userViewModelProvider);
    if (chatState is LoadingChatState) {
      return ChatLoading(chatRoomId: widget.chatRoomId);
    }
    if (chatState is LoadedChatState && userState is LoadedUserState) {
      final messages = ref.watch(chatMessageViewModelProvider(widget.chatRoomId));
      final chatData = chatState.infoResponse;
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(focusNode);
        },
        child: DefaultLayout(
          needBackButton: true,
          resizeToAvoidBottomInset: true,
          backAction: () {
            context.pop();
          },
          action: [
            ChatActionButton(
                chatRoom: chatData.chatRoomInfo, chatInfo: chatData),
          ],
          title: chatData.chatRoomInfo.name,
          child: Chat(
            isLeftStatus: true,
            messages: messages,
            scrollPhysics: const AlwaysScrollableScrollPhysics(),
            key: _chatKey,
            onSendPressed: (text) {
              if (text.text.isNotEmpty && mounted) {
                ref.read(chatMessageViewModelProvider(widget.chatRoomId).notifier).sendMessage(
                      text.text,
                    );
              }
            },
            showUserAvatars: true,
            showUserNames: true,
            onEndReached: () async {
              _handleEndReached();
            },
            onEndReachedThreshold: 0.3,
            user: types.User(
              id: userState.user.userId.toString(),
            ),
            emptyState: Center(
              child: Text(
                '대화를 주고받아 보세요!',
                style: headerText3,
              ),
            ),
            nameBuilder: (user) {
              final userName = chatData.chatRoomUsers.firstWhere((u) => u.userId == int.parse(user.id)).nickname;
              return Text(
                userName,
                style: TextStyle(fontWeight: FontWeight.bold),
              );
            },
            avatarBuilder: (user) {
              final userImage = chatData.chatRoomUsers.firstWhere((u) => u.userId == int.parse(user.id)).image;
              return Container(
                margin: EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundImage: userImage == "" ? null : NetworkImage(userImage),
                  radius: 17,
                ),
              );
            },
            dateLocale: 'ko_KR',
            timeFormat: DateFormat('a h시 m분', 'ko_KR'),
            customBottomWidget: ChatBottomBar(
              controller: textController,
              sendPressed: (text) {
                if (text.isNotEmpty && mounted) {
                  ref.read(chatMessageViewModelProvider(widget.chatRoomId).notifier).sendMessage(
                        text,
                      );
                }
              },
            ),
            customStatusBuilder: (message, {required BuildContext context}) {
              final int totalUsers = chatData.chatRoomUsers.length;
              final int readMembersCount = (message.metadata?['readMember'] as List?)?.length ?? totalUsers - 1;
              final int unreadMembersCount = totalUsers - readMembersCount;
              return unreadMembersCount <= 0 ? const Text('') : Text('$unreadMembersCount', style: bodyText1);
            },
            theme: DefaultChatTheme(
              messageBorderRadius: 10,
              messageInsetsHorizontal: 10.w,
              messageInsetsVertical: 6.w,
              primaryColor: main1,
              receivedMessageBodyTextStyle: headerText5,
              dateDividerTextStyle: bodyText1.copyWith(color: base5),
              bubbleMargin:
                  EdgeInsets.symmetric(vertical: 1.w, horizontal: 14.w),
            ),
          ),
        ),
      );
    } else {
      return const ChatError();
    }
  }
}

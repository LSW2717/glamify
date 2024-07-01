import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/chat/component/chat_action_button.dart';
import 'package:glamify/chat/component/chat_error.dart';
import 'package:glamify/chat/component/chat_loading.dart';
import 'package:glamify/chat/view_model/chat_detail_view_model.dart';
import 'package:glamify/chat/view_model/chat_message_view_model.dart';
import 'package:glamify/home/view_model/home_random_chat_view_model.dart';
import 'package:glamify/user/model/user_model.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../common/component/alert_message.dart';
import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/data_source/data.dart';
import '../../common/layout/default_layout.dart';
import '../../common/view_model/get_token_view_model.dart';
import '../component/chat_bottom_bar.dart';
import '../model/chat_message_response.dart';
import '../model/chat_room_request_model.dart';
import '../model/chat_room_response_model.dart';
import '../view_model/chat_list_view_model.dart';

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
  late WebSocketChannel _channel;
  late FocusNode focusNode;
  final GlobalKey<ChatState> _chatKey = GlobalKey();
  Timer? _throttleTimer;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    focusNode = FocusNode();
    final token = ref.read(getTokenViewModelProvider);
    _channel = WebSocketChannel.connect(Uri.parse('$socketUrl/$token'));
    print('$socketUrl/$token');
    _channel.stream.listen((message) {
      print(message);
      final Map<String, dynamic> decodedMessage = json.decode(message);
      final chatMessage = ChatMessageResponse.fromJson(decodedMessage);
      print(chatMessage.data.chatId);
      print(chatMessage);
      final textMessage = types.TextMessage(
        author: types.User(id: chatMessage.data.senderId.toString()),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: chatMessage.data.chatId,
        text: chatMessage.data.message,
      );
      if (mounted) {
        setState(() {
          ref.read(chatMessageProvider.notifier).addMessage(textMessage);
        });
      }
    });
  }

  void _handleEndReached() {
    if (_throttleTimer?.isActive == true) {
      return;
    }
    if (mounted) {
      setState(() {
        ref.read(chatMessageProvider.notifier)
            .getMessageList(widget.chatRoomId);
        _throttleTimer = Timer(const Duration(milliseconds: 300), () {});
      });
    }
  }

  @override
  void dispose() {
    textController.dispose();
    _channel.sink.close();
    focusNode.dispose();
    _throttleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatDetailProvider);
    final userState = ref.watch(userViewModelProvider);
    if (chatState is LoadingChatState) {
      return const ChatLoading();
    }
    if (chatState is LoadedChatState && userState is LoadedUserState) {
      final chatData = chatState.infoResponse;
      final messages = ref.watch(chatMessageProvider);
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(focusNode);
        },
        child: DefaultLayout(
          needBackButton: true,
          resizeToAvoidBottomInset: true,
          backAction: (){
            context.pop();
            ref.read(chatListProvider.notifier).updateChatList();
            ref.read(chatDetailProvider.notifier).updateMessageReadCount(chatData.chatRoomInfo.chatRoomId);
            ref.refresh(chatMessageProvider);
          },
          action: [
            ChatActionButton(chatRoom: chatData.chatRoomInfo, chatInfo: chatData),
          ],
          title: chatData.chatRoomInfo.name,
          child: Chat(
            messages: messages,
            scrollPhysics: const AlwaysScrollableScrollPhysics(),
            isLastPage: ref.read(chatMessageProvider.notifier).isLast,
            key: _chatKey,
            onSendPressed: (text) {
              if (text.text.isNotEmpty && mounted) {
                ref.read(chatMessageProvider.notifier).sendMessage(
                      text.text,
                      widget.chatRoomId,
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
            dateLocale: 'ko_KR',
            timeFormat: DateFormat('a h시 m분', 'ko_KR'),
            customBottomWidget: ChatBottomBar(
              controller: textController,
              sendPressed: (text) {
                if (text.isNotEmpty && mounted) {
                  ref.read(chatMessageProvider.notifier).sendMessage(
                        text,
                        chatData.chatRoomInfo.chatRoomId,
                      );
                }
              },
            ),
            theme: DefaultChatTheme(
              messageBorderRadius: 10,
              messageInsetsHorizontal: 10.w,
              messageInsetsVertical: 6.w,
              primaryColor: main1,
              receivedMessageBodyTextStyle: headerText5,
              dateDividerTextStyle: bodyText1.copyWith(color: base5),
            ),
          ),
        ),
      );
    } else {
      return const ChatError();
    }
  }
}

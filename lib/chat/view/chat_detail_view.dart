import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/chat/component/chat_error.dart';
import 'package:glamify/chat/component/chat_loading.dart';
import 'package:glamify/chat/view_model/chat_detail_view_model.dart';
import 'package:glamify/chat/view_model/chat_message_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/data_source/data.dart';
import '../../common/layout/default_layout.dart';
import '../../common/view_model/get_token_view_model.dart';
import '../component/chat_bottom_bar.dart';
import '../model/chat_message_response.dart';
import '../model/chat_room_response_model.dart';

class ChatDetailView extends ConsumerStatefulWidget {
  final ChatRoomResponse chatRoom;
  const ChatDetailView({
    required this.chatRoom,
    super.key,
  });

  @override
  ConsumerState<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends ConsumerState<ChatDetailView> {
  late TextEditingController controller;
  late WebSocketChannel _channel;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    focusNode = FocusNode();
    final token = ref.read(getTokenViewModelProvider);
    _channel = WebSocketChannel.connect(Uri.parse('$socketUrl/$token'));
    print('$socketUrl/$token');
    _channel.stream.listen((message) {
      final Map<String, dynamic> decodedMessage = json.decode(message);
      final chatMessage = ChatMessageResponse.fromJson(decodedMessage);
      final textMessage = types.TextMessage(
        author: types.User(id: chatMessage.data.senderId.toString()),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: chatMessage.data.message,
      );
      setState(() {
        ref.read(chatMessageProvider.notifier).addMessage(textMessage);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessageProvider);
    final chatState = ref.watch(chatDetailProvider);
    if(chatState is LoadingChatState){
      return ChatLoading(chatRoom: widget.chatRoom);
    }
    if(chatState is LoadedChatState){
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(focusNode);
        },
        child: DefaultLayout(
          needBackButton: true,
          resizeToAvoidBottomInset: true,
          action: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                size: 25.w,
                color: Colors.black,
              ),
            ),
          ],
          title: widget.chatRoom.name,
          child: Chat(
            messages: messages,
            onSendPressed: (text) {},
            showUserAvatars: true,
            showUserNames: true,
            user: User(id: widget.chatRoom.ownerUserId.toString(),firstName: widget.chatRoom.name),
            emptyState: Center(
              child: Text(
                '대화를 주고받아 보세요!',
                style: headerText3,
              ),
            ),
            customBottomWidget: ChatBottomBar(
              controller: controller,
              sendPressed: (text) {
                setState(() {
                  if (text.isNotEmpty) {
                    ref.read(chatMessageProvider.notifier).sendMessage(text, 6, widget.chatRoom.ownerUserId.toString());
                  }
                });
              },
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
        ),
      );
    }
    else{
      return ChatError(chatRoom: widget.chatRoom);
    }
  }
}

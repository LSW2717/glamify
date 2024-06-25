
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:glamify/chat/view_model/get_token_view_model.dart';
import 'package:glamify/common/data_source/data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;


import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/layout/default_layout.dart';
import '../component/chat_bottom_bar.dart';

class ChatDetailView extends ConsumerStatefulWidget {
  final types.User user;

  const ChatDetailView({
    required this.user,
    super.key,});

  @override
  ConsumerState<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends ConsumerState<ChatDetailView> {
  late TextEditingController controller;
  late final List<types.Message> _messages = [];
  late WebSocketChannel channel;
  late FlutterSecureStorage storage;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    // _loadMessages();
    final token = ref.read(getTokenViewModelProvider);
    print(token);
    channel = WebSocketChannel.connect(Uri.parse('$socketUrl/$token'));
    print('$socketUrl/$token');
    channel.stream.listen((message){
      setState(() {
        _messages.add(message);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    channel.sink.close(status.normalClosure);
    super.dispose();
  }
  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: widget.user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _sendPressed(String text) {
    if (text.isNotEmpty) {
      final message = types.PartialText(text: text);
      final textMessage = types.TextMessage(
        author: widget.user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: message.text,
      );
      channel.sink.add(textMessage);
      _addMessage(textMessage);
    }
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
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
        title: widget.user.firstName,
        child: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: widget.user,
          emptyState: Center(child: Text('대화를 주고받아 보세요!',style: headerText3,),),
          customBottomWidget: ChatBottomBar(
            controller: controller,
            sendPressed: _sendPressed,
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
}

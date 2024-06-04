import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/layout/default_layout.dart';
import '../component/chat_bottom_bar.dart';

class ChatDetailView extends ConsumerStatefulWidget {
  const ChatDetailView({super.key});

  @override
  ConsumerState<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends ConsumerState<ChatDetailView> {
  late TextEditingController controller;
  List<types.Message> _messages = [
    types.TextMessage(
      author: types.User(id: '1'),
      createdAt:
          DateTime.now().subtract(Duration(minutes: 5)).millisecondsSinceEpoch,
      id: '1',
      text: '안녕하세요, 오늘 기분이 어때요?',
    ),
    types.TextMessage(
      author: types.User(id: '2'),
      createdAt:
          DateTime.now().subtract(Duration(minutes: 4)).millisecondsSinceEpoch,
      id: '2',
      text: '안녕하세요! 기분이 좋습니다. 당신은요?',
    ),
    types.TextMessage(
      author: types.User(id: '1'),
      createdAt:
          DateTime.now().subtract(Duration(minutes: 3)).millisecondsSinceEpoch,
      id: '3',
      text: '저도 좋습니다. 오늘 날씨가 참 좋네요.',
    ),
    types.TextMessage(
      author: types.User(id: '2'),
      createdAt:
          DateTime.now().subtract(Duration(minutes: 2)).millisecondsSinceEpoch,
      id: '4',
      text: '네, 산책하기 딱 좋은 날씨입니다.',
    ),
  ];

  final _user = const types.User(
    id: '1',
  );

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _loadMessages();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
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
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: message.text,
      );

      _addMessage(textMessage);
    }
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
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
      title: '성락현',
      child: Chat(
        messages: _messages,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        showUserAvatars: true,
        showUserNames: true,
        user: _user,
        customBottomWidget: ChatBottomBar(
          controller: controller,
          sendPressed: _sendPressed,
        ),
        theme: DefaultChatTheme(
          messageBorderRadius: 10,
          messageInsetsHorizontal: 10.w,
          messageInsetsVertical: 6.w,
          primaryColor: Colors.white,
          receivedMessageBodyTextStyle: headerText5,
          dateDividerTextStyle: bodyText2.copyWith(color: base5),

        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/common/layout/default_layout.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../model/chat_room_response_model.dart';
import 'chat_bottom_bar.dart';

class ChatLoading extends StatefulWidget {
  final ChatRoomResponse chatRoom;

  const ChatLoading({
    required this.chatRoom,
    super.key,
  });

  @override
  State<ChatLoading> createState() => _ChatLoadingState();
}

class _ChatLoadingState extends State<ChatLoading> {
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
      title: '',
      child: Chat(
        messages: const [],
        onSendPressed: (text) {},
        showUserAvatars: true,
        showUserNames: true,
        user: User(id: widget.chatRoom.ownerUserId.toString(),firstName: widget.chatRoom.name),
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

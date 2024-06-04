import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/chat/view_model/chat_message_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/layout/default_layout.dart';
import '../component/chat_bottom_bar.dart';

class ChatDetailView extends HookConsumerWidget {
  final User user;

  const ChatDetailView({
    required this.user,
    super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final messages = ref.watch(messageViewModelProvider(user));
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
        title: '성락현',
        child: Column(
          children: [
            Expanded(
              child: Chat(
                messages: messages,
                onSendPressed: ref.read(messageViewModelProvider(user).notifier).handleSendPressed,
                showUserAvatars: true,
                showUserNames: true,
                user: user,
                customBottomWidget: ChatBottomBar(
                  controller: controller,
                  sendPressed: ref.read(messageViewModelProvider(user).notifier).sendPressed,
                ),
                theme: DefaultChatTheme(
                  messageBorderRadius: 10,
                  messageInsetsHorizontal: 10.w,
                  messageInsetsVertical: 6.w,
                  primaryColor: Colors.pinkAccent,
                  receivedMessageBodyTextStyle: headerText5,
                  dateDividerTextStyle: bodyText2.copyWith(color: base5),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

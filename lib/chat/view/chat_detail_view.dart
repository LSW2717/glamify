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
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/layout/default_layout.dart';
import '../component/chat_bottom_bar.dart';
import '../model/chat_room_response_model.dart';

class ChatDetailView extends ConsumerStatefulWidget {
  final int chatRoomId;

  const ChatDetailView({
    required this.chatRoomId,
    super.key,
  });

  @override
  ConsumerState<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends ConsumerState<ChatDetailView>
    with WidgetsBindingObserver {
  late TextEditingController textController;
  late FocusNode focusNode;
  final GlobalKey<ChatState> _chatKey = GlobalKey();
  Timer? _throttleTimer;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    WidgetsBinding.instance.addObserver(this);
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      ref.refresh(chatMessageViewModelProvider(0));
    } else if (state == AppLifecycleState.resumed) {
      print('이거');
      ref.refresh(chatMessageViewModelProvider(widget.chatRoomId));
      ref.refresh(chatDetailViewModelProvider(widget.chatRoomId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatDetailViewModelProvider(widget.chatRoomId));
    final userState = ref.watch(userViewModelProvider);
    if (chatState is LoadingChatState) {
      return ChatLoading(chatRoomId: widget.chatRoomId);
    }
    if (chatState is LoadedChatState && userState is LoadedUserState) {
      final messages =
          ref.watch(chatMessageViewModelProvider(widget.chatRoomId));
      final chatData = chatState.infoResponse;

      final ChatRoomUserResponse emptyUser = ChatRoomUserResponse(
        userId: -1,
        nickname: '알수 없음',
        image: '',
        messageReadCount: 0,
        updateDate: DateTime.fromMillisecondsSinceEpoch(0),
      );

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
                ref
                    .read(chatMessageViewModelProvider(widget.chatRoomId)
                        .notifier)
                    .sendMessage(text.text);
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
            emptyState: const Center(
              child: Text(
                '',
              ),
            ),
            nameBuilder: (user) {
              if (chatData.chatRoomUsers.isEmpty) {
                return const Text(
                  '알수 없음',
                  style: TextStyle(fontWeight: FontWeight.bold),
                );
              }
              final foundUser = chatData.chatRoomUsers.firstWhere(
                (u) => u.userId == int.parse(user.id),
                orElse: () => emptyUser,
              );
              final userName =
                  foundUser.nickname.isNotEmpty ? foundUser.nickname : '알수 없음';
              return Text(
                userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              );
            },
            avatarBuilder: (user) {
              if (chatData.chatRoomUsers.isEmpty) {
                return Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: const CircleAvatar(
                    backgroundImage: null,
                    radius: 17,
                  ),
                );
              }
              final foundUser = chatData.chatRoomUsers.firstWhere(
                (u) => u.userId == int.parse(user.id),
                orElse: () => emptyUser,
              );
              final userImage =
                  foundUser.image.isNotEmpty ? foundUser.nickname : '';
              return Container(
                margin: EdgeInsets.only(right: 5.w),
                child: CircleAvatar(
                  backgroundImage:
                      userImage.isEmpty ? null : NetworkImage(userImage),
                  radius: 17,
                ),
              );
            },
            dateLocale: 'ko_KR',
            timeFormat: DateFormat('a h시 m분', 'ko_KR'),
            customBottomWidget: ChatBottomBar(
              controller: textController,
              sendImage: () async {
                ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if(image != null){
                  ref
                      .read(chatMessageViewModelProvider(widget.chatRoomId)
                      .notifier)
                      .sendImageMessage(image);
                }
              },
              sendPressed: (text) {
                if (text.isNotEmpty && mounted) {
                  ref
                      .read(chatMessageViewModelProvider(widget.chatRoomId)
                          .notifier)
                      .sendMessage(text);
                }
              },
            ),
            customStatusBuilder: (message, {required BuildContext context}) {
              final int totalUsers = chatData.chatRoomUsers.length;
              final int readMembersCount =
                  (message.metadata?['readMember'] as List?)?.length ??
                      totalUsers - 1;
              final int unreadMembersCount = totalUsers - readMembersCount;
              return unreadMembersCount <= 0
                  ? const Text('')
                  : Text('$unreadMembersCount', style: bodyText1);
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
              userAvatarNameColors: const [main1, main2],
            ),
          ),
        ),
      );
    } else {
      return const ChatError();
    }
  }
}

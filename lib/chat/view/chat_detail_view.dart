import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:transparent_image/transparent_image.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/global_variable/global_variable.dart';
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
      String? previousAuthorId;
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
            imageGalleryOptions: ImageGalleryOptions(
              maxScale: 300.w,
              minScale: 300.w,
            ),
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
            bubbleBuilder: (
              Widget child, {
              required types.Message message,
              required bool nextMessageInGroup,
            }) {
              int messageIndex =
                  messages.indexWhere((msg) => msg.id == message.id);
              try {
                if (message is types.ImageMessage) {
                  final imageUrl = message.uri;
                  final int totalUsers = chatData.chatRoomUsers.length;
                  final int readMembersCount =
                      (message.metadata?['readMember'] as List?)?.length ??
                          totalUsers - 1;
                  final int unreadMembersCount = totalUsers - readMembersCount;
                  unreadMembersCount == totalUsers ? unreadMembersCount - 1 : unreadMembersCount;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 1),
                    child: GestureDetector(
                      onTap: () {
                        if (GlobalVariable.naviagatorState.currentContext !=
                            null) {
                          GlobalVariable.naviagatorState.currentContext!
                              .push('/fullScreenGallery', extra: imageUrl);
                        }
                      },
                      child: Row(
                        mainAxisAlignment:
                        message.author.id == userState.user.userId.toString()
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if(message.author.id == userState.user.userId.toString())
                            unreadMembersCount <= 0
                                ? const Text('')
                                : Row(
                              children: [
                                Text('$unreadMembersCount', style: bodyText1.copyWith(height: 2)),
                                SizedBox(width: 3.w),
                              ],
                            ),
                          if(message.author.id != userState.user.userId.toString())
                            SizedBox(width: 45.w),
                          Container(
                            width: 255.w,
                            height: 300.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: gray50,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                width: 260.w,
                                height: 300.w,
                                placeholder: (context, url) =>
                                    Image.memory(kTransparentImage),
                                errorWidget: (context, url, error) => Container(
                                  color: gray100,
                                  child: Center(
                                    child: Icon(
                                      Icons.warning,
                                      size: 80.w,
                                    ),
                                  ),
                                ),
                                fadeInDuration: const Duration(milliseconds: 100),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          if(message.author.id != userState.user.userId.toString())
                            unreadMembersCount <= 0
                                ? const Text('')
                                : Row(
                              children: [
                                SizedBox(width: 3.w),
                                Text('$unreadMembersCount', style: bodyText1.copyWith(height: 2)),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                } else if (message is types.TextMessage) {
                  final foundUser = chatData.chatRoomUsers.firstWhere(
                    (u) => u.userId == int.parse(message.author.id),
                    orElse: () => emptyUser,
                  );
                  final int totalUsers = chatData.chatRoomUsers.length;
                  final int readMembersCount =
                      (message.metadata?['readMember'] as List?)?.length ??
                          totalUsers - 1;
                  final int unreadMembersCount = totalUsers - readMembersCount;
                  final userImageUrl = chatData.chatRoomUsers.firstWhere((user) => message.author.id == user.userId.toString()).image;
                  unreadMembersCount == totalUsers ? unreadMembersCount - 1 : unreadMembersCount;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 1.0),
                    child: Row(
                      mainAxisAlignment:
                          message.author.id == userState.user.userId.toString()
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if(message.author.id == userState.user.userId.toString())
                        unreadMembersCount <= 0
                            ? const Text('')
                            : Row(
                              children: [
                                Text('$unreadMembersCount', style: bodyText1.copyWith(height: 2)),
                                SizedBox(width: 3.w),
                              ],
                            ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(userState.user.userId.toString() !=
                                message.author.id)
                            userState.user.userId.toString() !=
                                message.author.id &&
                                messages[messageIndex + 1].author.id ==
                                    userState.user.userId.toString() ?
                            Column(
                              children: [
                                SizedBox(height: 5.w),
                                Container(
                                  width: 35.w,
                                  height: 35.w,
                                  margin: EdgeInsets.only(right: 10.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: userImageUrl,
                                      width: 35.w,
                                      height: 35.w,
                                      placeholder: (context, url) =>
                                          Image.memory(kTransparentImage),
                                      errorWidget: (context, url, error) => Container(
                                        color: base3,
                                        child: Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 25.w,
                                          ),
                                        ),
                                      ),
                                      fadeInDuration: const Duration(milliseconds: 100),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ) : SizedBox(width: 45.w,),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 259.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (userState.user.userId.toString() !=
                                      message.author.id &&
                                      messages[messageIndex + 1].author.id ==
                                          userState.user.userId.toString())
                                    Text(foundUser.nickname, style: headerText5),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 1.w),
                                    padding: EdgeInsets.symmetric(vertical: 1.w),
                                    decoration: BoxDecoration(
                                      color: message.author.id == userState.user.userId.toString() ? main1 : base2,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: child,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if(message.author.id != userState.user.userId.toString())
                          unreadMembersCount <= 0
                              ? const Text('')
                              : Row(
                                children: [
                                  SizedBox(width: 3.w),
                                  Text('$unreadMembersCount', style: bodyText1.copyWith(height: 2)),
                                ],
                              ),
                      ],
                    ),
                  );
                } else {
                  return child;
                }
              } catch (e) {
                print(e.toString());
              } finally {
                previousAuthorId = message.author.id;
              }
              return child;
            },
            dateLocale: 'ko_KR',
            timeFormat: DateFormat('a h시 m분', 'ko_KR'),
            customBottomWidget: ChatBottomBar(
              controller: textController,
              sendImage: () async {
                ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
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
            theme: DefaultChatTheme(
              messageBorderRadius: 10,
              messageInsetsHorizontal: 10.w,
              messageInsetsVertical: 6.w,
              primaryColor: main1,
              receivedMessageBodyTextStyle: headerText4,
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

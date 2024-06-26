import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/component/chat_item.dart';
import 'package:glamify/chat/view/chat_empty_view.dart';
import 'package:glamify/chat/view_model/chat_detail_view_model.dart';
import 'package:glamify/chat/view_model/chat_list_view_model.dart';
import 'package:glamify/chat/view_model/chat_message_view_model.dart';
import 'package:glamify/common/const/colors.dart';
import 'package:glamify/common/const/typography.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';

import '../../user/model/user_model.dart';

class ChatView extends ConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatListState = ref.watch(chatListProvider);
    final userState = ref.watch(userViewModelProvider);
    final chatState = ref.watch(chatDetailProvider);

    if (userState is! LoadedUserState) {
      return Center(
        child: Text(
          '로그인을해주세요!',
          style: headerText1,
        ),
      );
    }
    if (chatListState is LoadingChatListState) {
      return const Center(
        child: CircularProgressIndicator(
          color: main1,
        ),
      );
    }
    if (chatListState is ErrorChatListState) {
      return Center(
        child: Text(chatListState.errorMessage),
      );
    }
    if (chatListState is LoadedChatListState) {
      final chatList = chatListState.response.chatRoomList;
      return chatList.isEmpty
          ? const ChatEmptyView()
          : CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ...chatList.map(
                        (data) => ChatItem(
                          user: User(id: data.ownerUserId.toString()),
                          name: data.name,
                          lastMessage: data.lastMessage,
                          onTap: () {
                            ref
                                .read(chatMessageProvider.notifier)
                                .getMessageList(data.chatRoomId);
                            ref
                                .read(chatDetailProvider.notifier)
                                .getMessageInfo(data.chatRoomId);
                            context.push('/chatDetail',extra: data);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: main1,
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/component/chat_item.dart';
import 'package:glamify/chat/view_model/chat_list_view_model.dart';
import 'package:glamify/common/const/colors.dart';
import 'package:go_router/go_router.dart';

class ChatView extends ConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatListState = ref.watch(chatListProvider);
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
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                ...chatList.map(
                  (data) => ChatItem(
                    user: User(id: data.ownerUserId.toString()),
                    name: data.name,
                    lastMessage: '안냥하세여',
                    onTap: () {
                      context.push(
                        '/chatDetail',
                        extra: User(id: '2', firstName: '성락현'),
                      );
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

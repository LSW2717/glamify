import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/chat/component/chat_item.dart';
import 'package:glamify/chat/view/chat_empty_view.dart';
import 'package:glamify/chat/view/chat_invite_view.dart';
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
    if (chatListState is LoadedChatListState) {
      final chatList = chatListState.response.chatRoomList;
      final chatReadCount = chatListState.response.readCountList;
      return DefaultTabController(
            length: 2,
            child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    child: chatList.isEmpty
                        ? const ChatEmptyView() : Column(
                      children: [
                        SizedBox(height: 10.w),
                        ...chatList
                            .asMap()
                            .map((index, data) {
                          int unreadCount = 0;
                          if (index < chatReadCount.length) {
                            unreadCount = data.messageCount - chatReadCount[index].messageReadCount;
                          }
                          return MapEntry(
                            index,
                            ChatItem(
                              imageUrl: data.image,
                              name: data.name ?? '알수없음',
                              lastMessage: data.lastMessage,
                              onTap: () {
                                context.push('/chatDetail',
                                    extra: data.chatRoomId);
                              },
                              count: unreadCount,
                            ),
                          );
                        })
                            .values,
                      ],
                    ),
                  ),
                ],
              ),
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

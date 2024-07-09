import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/chat/model/chat_room_request_model.dart';
import 'package:glamify/chat/view_model/chat_detail_view_model.dart';
import 'package:glamify/chat/view_model/chat_invite_list_view_model.dart';
import 'package:glamify/common/const/typography.dart';
import 'package:glamify/common/layout/default_layout.dart';
import 'package:glamify/home/view_model/home_random_chat_view_model.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/alert_message.dart';
import '../../common/const/colors.dart';

class ChatInviteView extends ConsumerWidget {
  const ChatInviteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inviteState = ref.watch(chatInviteListProvider);
    if (inviteState is LoadingInviteState) {
      return const Center(
        child: CircularProgressIndicator(
          color: main1,
        ),
      );
    }
    if (inviteState is LoadedInviteState) {
      final inviteData = inviteState.response.chatInvitations;
      return SingleChildScrollView(
        child: inviteData.isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 390.w,
                    height: 600.w,
                    child: Center(
                      child: Text(
                        '현재는 친구추가 요청이 없어요!',
                        style: headerText3,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  ...inviteData.map((data) {
                    return Container(
                      width: 390.w,
                      height: 140.w,
                      margin: EdgeInsets.all(10.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '친구요청이 도착했어요!',
                            style: headerText2,
                          ),
                          Text(
                            '수락하시겠습니까?',
                            style: headerText5,
                          ),
                          SizedBox(height: 10.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  final bool confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlarmMessage(
                                            title: '수락',
                                            content: '대화를 시작하시겠어요?',
                                          );
                                        },
                                      ) ??
                                      false;
                                  if (confirm) {
                                    final InvitationRequest request =
                                        InvitationRequest(
                                            chatInvitationId:
                                                data.chatInvitationId);
                                    ref
                                        .read(chatInviteListProvider.notifier)
                                        .confirmInviteChat(request);
                                    ref
                                        .read(chatInviteListProvider.notifier)
                                        .getChatInviteList();
                                    ref.refresh(
                                        homeRandomChatViewModelProvider);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white, // 배경색 흰색
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // BorderRadius 10
                                  ),
                                ),
                                child: Text('수락', style: headerText4),
                              ),
                              SizedBox(width: 20.w),
                              ElevatedButton(
                                  onPressed: () async {
                                    final bool confirm =
                                        await showDialog<bool>(
                                              context: context,
                                              builder:
                                                  (BuildContext context) {
                                                return const AlarmMessage(
                                                  title: '거절',
                                                  content: '대화 싫어용?',
                                                );
                                              },
                                            ) ??
                                            false;
                                    if (confirm) {
                                      final InvitationRequest request =
                                          InvitationRequest(
                                              chatInvitationId:
                                                  data.chatInvitationId);
                                      ref
                                          .read(chatInviteListProvider.notifier)
                                          .rejectInviteChat(request);
                                      ref
                                          .read(
                                              chatInviteListProvider.notifier)
                                          .getChatInviteList();
                                      ref.refresh(
                                          homeRandomChatViewModelProvider);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white, // 배경색 흰색
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // BorderRadius 10
                                    ),
                                  ),
                                  child: Text('거절', style: headerText4)),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
      );
    } else {
      return const Center(
        child: Text('에러'),
      );
    }
  }
}

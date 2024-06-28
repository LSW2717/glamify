import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../model/chat_room_response_model.dart';

class ChatItem extends StatelessWidget {
  final User user;
  final String name;
  final String lastMessage;
  final VoidCallback onTap;
  final int count;

  const ChatItem({
    required this.user,
    required this.name,
    required this.lastMessage,
    required this.onTap,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 390.w,
            height: 100.w,
            color: Colors.white,
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 80.w,
                      height: 80.w,
                      child: user.imageUrl == null
                          ? Image.asset(
                              'asset/img/profile.png',
                              width: 80.w,
                              height: 80.w,
                            )
                          : Image.network(
                              '${user.imageUrl}',
                              width: 80.w,
                              height: 80.w,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(width: 17.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: headerText2,
                        ),
                        SizedBox(height: 5.w),
                        Text(
                          lastMessage,
                          style: headerText4.copyWith(color: gray700),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    )
                  ],
                ),
                count == 0 ? const SizedBox.shrink() : Container(
                  height: 30.w,
                  width: 30.w,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: main1,
                  ),
                  child: Center(
                    child: Text(
                      '+$count',
                      style: headerText5.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 358.w,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: gray500,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

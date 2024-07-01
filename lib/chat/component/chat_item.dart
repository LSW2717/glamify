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
    return Container(
      margin: EdgeInsets.all(5.w),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            width: 385.w,
            height: 100.w,
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: base3,
                      ),

                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 50.w,
                        ),
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
      ),
    );
  }
}

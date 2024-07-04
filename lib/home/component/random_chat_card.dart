import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/common/const/typography.dart';

import '../../chat/model/chat_room_response_model.dart';
import '../../common/const/colors.dart';

class RandomChatCard extends StatelessWidget {
  final ChatRoomResponse roomData;
  final VoidCallback onTap;

  const RandomChatCard({
    required this.roomData,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Container(
            width: 300.w,
            height: 400.w,
            padding: EdgeInsets.all(32.w),
            child: Column(
              children: [
                Container(
                  width: 200.w,
                  height: 200.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: base3,
                  ),

                  child: Center(
                    child: Icon(
                        Icons.person,
                        size: 150.w,
                      ),
                  ),
                ),
                SizedBox(height: 30.w),
                Text(roomData.name ?? '알수없음', style: headerText1.copyWith(fontWeight: FontWeight.w700),),
                SizedBox(height: 28.w),
                Text('매칭이 됐어요!\n클릭해서 대화를 진행해보세요!',style: headerText4,textAlign: TextAlign.center,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

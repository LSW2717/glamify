import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/common/const/typography.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:go_router/go_router.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  final User user = User(id: '2');
                  context.push('/chatDetail', extra: user);
                },
                child: Container(
                  width: 390.w,
                  height: 100.w,
                  color: Colors.white,
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Container(
                        width: 68.w,
                        height: 68.w,
                        decoration: ShapeDecoration(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Text('성락현',style: headerText4,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

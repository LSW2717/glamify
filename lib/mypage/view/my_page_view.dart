import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/common/const/typography.dart';
import 'package:glamify/mypage/view/my_page_login_view.dart';
import 'package:glamify/user/model/user_model.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';

import '../../common/const/colors.dart';

class MyPageView extends ConsumerWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);
    return userState is! LoadedUserState
        ? const MyPageLoginView()
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                userState.user.image.isEmpty
                    ? Container(
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
                      )
                    : InkWell(
                        customBorder: const CircleBorder(),
                        child: Container(
                          width: 160.w,
                          height: 160.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.pinkAccent,
                                width: 2.0), // 핑크색 테두리 추가
                          ),
                          child: ClipOval(
                            child: Image.network(
                              userState.user.image,
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 20.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userState.user.nickname,
                      style: headerText1.copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 4.w),
                    IconButton(
                      onPressed: () {
                        context.go('/updateNickname');
                      },
                      icon: Icon(Icons.accessible),
                    ),
                  ],
                ),
                SizedBox(height: 20.w),
              ],
            ),
          );
  }
}

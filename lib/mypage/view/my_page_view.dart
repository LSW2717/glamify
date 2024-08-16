import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/common/const/typography.dart';
import 'package:glamify/mypage/component/mypage_coin_controll.dart';
import 'package:glamify/mypage/component/mypage_page_button.dart';
import 'package:glamify/mypage/component/mypage_profile_button.dart';
import 'package:glamify/mypage/view/my_page_login_view.dart';
import 'package:glamify/user/model/user_model.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../common/const/colors.dart';

class MyPageView extends ConsumerWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);
    return userState is! LoadedUserState
        ? const MyPageLoginView()
        : Column(
      children: [
        Container(
          padding: EdgeInsets.all(20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 5.w),
                  userState.user.image.isEmpty
                      ? Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: base3,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 40.w,
                      ),
                    ),
                  )
                      : Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: userState.user.image,
                        width: 70.w,
                        height: 70.w,
                        placeholder: (context, url) =>
                            Image.memory(kTransparentImage),
                        errorWidget: (context, url, error) => Container(
                          color: base3,
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 40.w,
                            ),
                          ),
                        ),
                        fadeInDuration: const Duration(milliseconds: 100),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 160.w),
                    child: Text(
                      userState.user.nickname,
                      style:
                      headerText2.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              MyPageProfileButton(user: userState.user,),
            ],
          ),
        ),
        const MyPageCoinControll(),
        MyPageButton(
          title: '스토어',
          onTap: () {
          },
        ),
        MyPageButton(
          title: '문의하기',
          onTap: () {
            context.go('/report');
          },
        ),
        MyPageButton(
          title: '공지사항',
          onTap: () {},
        ),
        MyPageButton(
          title: '제보하기',
          onTap: () {},
        ),
        MyPageButton(
          title: '멀로 하징 ',
          onTap: () {},
        ),
      ],
    );
  }
}

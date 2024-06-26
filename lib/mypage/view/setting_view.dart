import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../common/component/alert_message.dart';
import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/layout/default_layout.dart';
import '../../user/view_model/auth_view_model.dart';

class SettingView extends ConsumerWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '설정',
      needBackButton: true,
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
            },
            child: Container(
              width: 375.w,
              height: 64.w,
              color: Colors.transparent,
              padding: EdgeInsets.only(
                left: 20.w,
                right: 16.w,
                top: 20.w,
                bottom: 20.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '알림 설정',
                    style: headerText4.copyWith(color: gray700),
                  ),
                  SvgPicture.asset('asset/svg/next.svg'),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              const url =
                  'https://roan-octagon-c70.notion.site/c0490db2d4a6412e83d27492ef0b5cd2';
              if (await canLaunchUrlString(url)) {
                await launchUrlString(url);
              } else {
                throw '링크를 열 수 없습니다.';
              }
            },
            child: Container(
              width: 375.w,
              height: 64.w,
              color: Colors.transparent,
              padding: EdgeInsets.only(
                left: 20.w,
                right: 16.w,
                top: 20.w,
                bottom: 20.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '서비스 이용약관',
                    style: headerText4.copyWith(color: gray700),
                  ),
                  SvgPicture.asset('asset/svg/next.svg'),
                ],
              ),
            ),
          ),
          Container(
            width: 375.w,
            height: 64.w,
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '버전',
                  style: headerText4.copyWith(color: gray700),
                ),
                SizedBox(
                  child: FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (BuildContext context,
                        AsyncSnapshot<PackageInfo> snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                          '최신버전',
                          style: bodyText2.copyWith(color: gray600),
                        );
                      } else if (!snapshot.hasData) {
                        return Text('최신버전',
                            style: bodyText2.copyWith(color: gray600));
                      }
                      final data = snapshot.data!;
                      return Text(
                        'v ${data.version}',
                        style: bodyText2.copyWith(color: gray600),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final bool confirm = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return const AlarmMessage(
                    title: '로그아웃',
                    content: '로그아웃 하시겠습니까?',
                  );
                },
              ) ??
                  false;
              if (confirm) {
                ref.read(authProvider.notifier).logout();
                context.pop();
              }
            },
            child: Container(
              width: 375.w,
              height: 64.w,
              color: Colors.transparent,
              padding: EdgeInsets.only(
                left: 20.w,
                right: 16.w,
                top: 20.w,
                bottom: 20.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '로그아웃',
                    style: headerText4.copyWith(color: gray700),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 350.h),
          GestureDetector(
            onTap: () async {
              final bool confirm = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return const AlarmMessage(
                    title: '정말로 탈퇴하시겠어요?',
                    content: '탈퇴 버튼을 누르면 계정은 삭제되며 복구되지 않습니다.',
                  );
                },
              ) ??
                  false;
              if (confirm) {
                ref.read(userViewModelProvider.notifier).unsubscribe();
              }
            },
            child: Text(
              '탈퇴하기',
              style: bodyText1.copyWith(color: gray500),
            ),
          ),
          // SizedBox(height: 52.w),
        ],
      ),
    );
  }
}

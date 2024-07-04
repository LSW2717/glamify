import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/mypage/view_model/noti_setting_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/component/cupertino_toggle_button.dart';
import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/layout/default_layout.dart';
import '../component/noti_setting_item.dart';

class NotiSettingView extends ConsumerWidget {
  const NotiSettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonState = ref.watch(notiSettingViewModelProvider);
    return DefaultLayout(
      title: '알림 설정',
      needBackButton: true,
      backAction: () { context.pop(); },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () => openAppSettings(),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 17.w,
                    bottom: 16.w,
                    left: 20.w,
                    right: 26.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '푸시 알림 설정',
                        style: headerText3.copyWith(
                          color: gray700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '시스템 설정을 변경합니다.',
                        style: bodyText1.copyWith(
                          color: gray500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          NotiSettingItemContainer(
            child: Padding(
              padding: EdgeInsets.only(
                top: 17.w,
                bottom: 16.w,
                left: 20.w,
                right: 26.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '푸시 알림',
                        style: headerText3.copyWith(
                          color: gray700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '푸시 알림을 받습니다.',
                        style: bodyText1.copyWith(
                          color: gray500,
                        ),
                      ),
                    ],
                  ),
                  CupertinoToggleSwitch(
                    value: buttonState,
                    onChanged: (_){
                      ref.read(notiSettingViewModelProvider.notifier).setAlarmState();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

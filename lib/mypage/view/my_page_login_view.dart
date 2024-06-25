import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/common/const/typography.dart';
import 'package:glamify/user/repository/user_repository.dart';

import '../../user/view_model/user_view_model.dart';

class MyPageLoginView extends ConsumerWidget {
  const MyPageLoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.w,
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 30.w),
                        Text('로그인이 필요해요', style: headerText3),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(userViewModelProvider.notifier).login();
                      },
                      child: Text('로그인'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 26.w),

        ],
      ),
    );
  }
}

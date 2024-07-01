import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/common/const/typography.dart';
import 'package:glamify/user/view_model/refresh_token_view_model.dart';

import '../../common/const/colors.dart';
import '../../user/view_model/user_view_model.dart';

class MyPageLoginView extends ConsumerWidget {
  const MyPageLoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String refreshToken = '';
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
                SizedBox(height: 100.w),
                TextFormField(
                  maxLines: 1,
                  onChanged: (value) {
                    refreshToken = value;
                  },
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: '토큰을 넣어주세요.',
                    hintStyle: headerText5.copyWith(color: gray500),
                    contentPadding: EdgeInsets.only(left: 16.w),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: gray100),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: main1),
                    ),
                  ),
                  style: bodyText2,
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async {
                    await ref.read(userViewModelProvider.notifier).tokenLogin(refreshToken);
                    },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return main1; // 버튼이 눌렸을 때의 색상
                        }
                        return main1; // 기본 색상
                      },
                    ),
                    minimumSize: WidgetStateProperty.all(Size(343.w, 53.w)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                    ),
                  ),
                  child: Text(
                    '저장하기',
                    style: bodyText1.copyWith(
                      color: Colors.white,
                    ),
                  ),
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

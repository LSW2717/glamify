import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/alert_message.dart';
import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/layout/default_layout.dart';

class UpdateNickNameView extends ConsumerWidget {
  const UpdateNickNameView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String nickname = '';
    return DefaultLayout(
      title: '내 정보 수정',
      needBackButton: true,
      backgroundColor: Colors.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 40.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '닉네임',
                        style: bodyText2.copyWith(color: gray650),
                      ),
                      SizedBox(
                        width: 12.w,
                        height: 12.w,
                        child: Center(
                          child: Text(
                            '*',
                            textAlign: TextAlign.center,
                            style: bodyText2.copyWith(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.w),
                  SizedBox(
                    width: 335.w,
                    height: 54.w,
                    child: TextFormField(
                      maxLines: 1,
                      onChanged: (value) {
                        nickname = value;
                      },
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: '닉네임을 입력해주세요.',
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
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final bool confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlarmMessage(
                            title: '수정',
                            content: '닉네임을 수정하시겠습니까?',
                          );
                        },
                      ) ??
                          false;
                      if (confirm) {
                        try {
                          await ref.read(userViewModelProvider.notifier).updateNickname(nickname);
                          context.pop();
                        } catch (e) {
                          if (nickname.contains(' ')){
                            Fluttertoast.showToast(
                              msg: "띄어쓰기는 들어갈 수 없어요!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.sp,
                            );
                          } else{
                            print(e.toString());
                            Fluttertoast.showToast(
                              msg: "중복된 아이디가 존재해요!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.sp,
                            );
                          }
                        }
                      }
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
                  SizedBox(height: 17.w),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


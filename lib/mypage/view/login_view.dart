import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glamify/common/layout/default_layout.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../user/view_model/user_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late TextEditingController refreshToken;

  @override
  void initState() {
    refreshToken = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    refreshToken.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: DefaultLayout(
        needBackButton: false,
        resizeToAvoidBottomInset: true,
        title: '',
        backAction: () {},
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GLAMIFY',
                style: headerText1.copyWith(fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 18.w),
              Text(
                '로그인을 하고 즐겨보세요!',
                style: headerText2.copyWith(
                  color: gray700,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 170.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(userViewModelProvider.notifier).login();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'asset/svg/kakao.svg',
                            width: 64.w,
                            height: 64.w,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'asset/svg/kakaologo.svg',
                            width: 28.w,
                            height: 28.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100.h),
              TextFormField(
                maxLines: 1,
                onChanged: (value) {
                  refreshToken.text = value;
                },
                controller: refreshToken,
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
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  await ref.read(userViewModelProvider.notifier).tokenLogin(refreshToken.text);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return base3; // 버튼이 눌렸을 때의 색상
                      }
                      return base3; // 기본 색상
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
                  '토큰으로 로그인하기',
                  style: bodyText1.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 78.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                    },
                    child: Text(
                      '서비스 이용약관',
                      style: bodyText1.copyWith(
                        color: gray500,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: () async {
                    },
                    child: Text(
                      '개인정보 처리방침',
                      style: bodyText1.copyWith(
                        color: gray500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.w),
            ],
          ),
        ),
      ),
    );
  }
}


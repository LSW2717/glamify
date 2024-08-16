import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';

class MyPageCoinControll extends StatelessWidget {
  const MyPageCoinControll({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90.w,
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.w,
        bottom: 10.w,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 14.w,
        horizontal: 60.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: gray50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 80.w,
            height: 60.w,
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: main3,
                        radius: 15,
                        child: Center(
                          child: SvgPicture.asset(
                            'asset/svg/C.svg',
                            width: 14.w,
                            height: 14.w,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '100',
                        style: headerText3.copyWith(
                            color: main3,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.w),
                  Text(
                    '코인',
                    style: headerText4.copyWith(
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 80.w,
            height: 60.w,
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: gray600,
                        radius: 15,
                        child: Center(
                          child: SvgPicture.asset(
                            'asset/svg/C.svg',
                            width: 14.w,
                            height: 14.w,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '100',
                        style: headerText3.copyWith(
                            color: gray600,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.w),
                  Text(
                    '사용한 코인',
                    style: headerText4.copyWith(
                        fontWeight: FontWeight.w700),
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

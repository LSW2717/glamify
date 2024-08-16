import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../user/model/user_model.dart';

class MyPageProfileButton extends StatelessWidget {
  final UserModel user;

  const MyPageProfileButton({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.go('/updateNickname',extra: user);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        padding: EdgeInsets.all(10.w),
        elevation: 0,
        side: const BorderSide(color: gray400, width: 1),
        // Border color and width
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Border radius
        ),
      ),
      child: Row(
        children: [
          Text(
            '프로필 수정',
            style: headerText5.copyWith(
                color: gray700, fontWeight: FontWeight.w700),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: gray700,
            size: 15,
          ),
        ],
      ),
    );
  }
}

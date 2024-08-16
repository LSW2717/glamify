import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';

class MyPageButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MyPageButton({
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60.w,
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: headerText4,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: gray700,
                  size: 15.w,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(
              thickness: 1.0,
              height: 0,
              color: gray50,
            ),
          ),
        ],
      ),
    );
  }
}

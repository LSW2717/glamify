import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../const/colors.dart';
import '../const/typography.dart';

class AlarmMessage extends StatelessWidget {
  final String? title;
  final String content;

  const AlarmMessage({
    this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.r),
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 10.w),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      title: title != null ? Text(
        title!,
        style: headerText2.copyWith(color: gray800),
      ) : null,
      content: Text(
        content,
        style: headerText4.copyWith(color: gray600),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(
            '취소',
            style: headerText4.copyWith(color: gray700),
          ),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(
            '확인',
            style: headerText4.copyWith(color: main1),
          ),
        ),
      ],
    );
  }
}

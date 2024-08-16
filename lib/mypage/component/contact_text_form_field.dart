import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';

class ContactTextFormField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final int? maxLine;
  final String hintText;
  final double? width;
  final double? height;

  const ContactTextFormField({
    required this.onChanged,
    this.maxLine,
    required this.hintText,
    this.width,
    this.height,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        maxLines: maxLine,
        onChanged: onChanged,
        controller: controller,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: headerText5.copyWith(color: gray500),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: gray100),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: main1),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        style: headerText5,
      ),
    );
  }
}

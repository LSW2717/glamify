

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';

class ChatTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) onSubmitted;

  const ChatTextFormField({
    required this.controller,
    required this.onSubmitted,
    super.key,
  });

  @override
  State<ChatTextFormField> createState() => _ChatTextFormFieldState();
}

class _ChatTextFormFieldState extends State<ChatTextFormField> {
  late FocusNode focusNode;
  double borderRadius = 15.0;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: widget.controller,
      textAlignVertical: TextAlignVertical.center,
      onFieldSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 0.w
        ),
        hintText: '메시지 보내기',
        hintStyle: headerText5.copyWith(
          color: base5,
        ),
        filled: true,
        fillColor: base2,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: base2),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: base2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: base2),
        ),
      ),
      expands: true,
      maxLines: null,
    );
  }
}

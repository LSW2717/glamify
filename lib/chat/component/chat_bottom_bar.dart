import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'chat_text_form_field.dart';

class ChatBottomBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> sendPressed;
  final VoidCallback sendImage;

  const ChatBottomBar({
    required this.controller,
    required this.sendImage,
    required this.sendPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200.w),
      child: IntrinsicHeight(
        child: SafeArea(
          child: Container(
            width: 390.w,
            color: Colors.white,
            padding: EdgeInsets.only(
                top: 10.w, left: 21.w, right: 7.w, bottom: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: ChatTextFormField(
                    controller: controller,
                    onSubmitted: (text) {
                      sendPressed(text);
                      controller.clear();
                    },
                  ),
                ),
                IconButton(
                  onPressed: sendImage,
                  icon: const Icon(
                    Icons.image,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendPressed(controller.text);
                    controller.clear();
                  },
                  icon: const Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.pinkAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

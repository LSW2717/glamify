import 'package:flutter/material.dart';
import 'package:glamify/common/const/typography.dart';

class ChatEmptyView extends StatelessWidget {
  const ChatEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '진행중인 대화방이 없어요!',
        style: headerText2,
      ),
    );
  }
}

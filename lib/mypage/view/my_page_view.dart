import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify_mobile/mypage/view/my_page_login_view.dart';
import 'package:glamify_mobile/user/model/user_model.dart';
import 'package:glamify_mobile/user/view_model/user_view_model.dart';

class MyPageView extends ConsumerWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);
    return userState is! LoadedUserState ? const MyPageLoginView() : Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              ref.read(userViewModelProvider.notifier).login();
            },
            child: Text('로그인'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(userViewModelProvider.notifier).logout();
            },
            child: Text('로그아웃'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(userViewModelProvider.notifier).healthCheck();
            },
            child: Text('체크체크'),
          ),
        ],
      ),
    );
  }
}

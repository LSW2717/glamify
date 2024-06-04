import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/common/test_data/test_page1.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../chat/view/chat_view.dart';
import '../../home/view/home_view.dart';
import '../../mypage/view/my_page_view.dart';
import '../const/colors.dart';
import '../layout/default_layout.dart';
import '../view_model/tab_index_view_model.dart';

class RootTab extends HookConsumerWidget {
  const RootTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();
    final currentIndex = ref.watch(tabIndexViewModelProvider(controller));

    return DefaultLayout(
      title: _getTitleFromTabIndex(currentIndex),
      needBackButton: false,
      backgroundColor: Colors.white,
      action: _getActionsFromTabIndex(currentIndex, context, ref),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: gray500,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          ref.read(tabIndexViewModelProvider(controller).notifier).setIndex(index);
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: '멀로하징',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
      ),
      child: IndexedStack(
        index: currentIndex,
        children: const [
          HomeView(),
          TestPage1(),
          ChatView(),
          MyPageView(),
        ],
      ),
    );
  }

  String? _getTitleFromTabIndex(int index) {
    switch (index) {
      case 0:
        return 'GLAMIFY';
      case 1:
        return '홀';
      case 2:
        return '채팅';
      case 3:
        return '마이페이지';
      default:
        return null;
    }
  }

  List<Widget>? _getActionsFromTabIndex(
    int index,
    BuildContext context,
    WidgetRef ref,
  ) {
    if (index == 0) {
      return [
        Padding(
          padding: EdgeInsets.only(
            right: 10.w,
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () async {},
            splashRadius: 24.w, // 필요에 따라 조정
          ),
        ),
      ];
    } else if (index == 3) {
      return [
        Padding(
          padding: EdgeInsets.only(
            right: 10.w,
          ),
          child: IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
            splashRadius: 24.w, // 필요에 따라 조정
          ),
        ),
      ];
    }

    return null;
  }
}

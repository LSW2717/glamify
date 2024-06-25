import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glamify/common/const/typography.dart';
import 'package:glamify/common/firebase_setting/firebase_handler.dart';
import 'package:glamify/home/view_model/home_matching_button_view_model.dart';

import '../../common/const/colors.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      );
    });
    _animations = _controllers.map((controller) {
      return Tween(begin: 1.0, end: 2.0).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));
    }).toList();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        ref.read(homeMatchingButtonViewModelProvider(_controllers,_animations).notifier).toggleButton();
        _showBottomSheet(message.notification!.title, message.notification!.body);
      }
    });
  }
  void _showBottomSheet(String? title, String? body) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          height: 700,
          width: 390.w,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title ?? 'No Title', style: TextStyle(fontSize: 24.0)),
              SizedBox(height: 8.0),
              Text(body ?? 'No Body', style: TextStyle(fontSize: 16.0)),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matchingButton = ref.watch(homeMatchingButtonViewModelProvider(_controllers,_animations));
    if (matchingButton) {
      ref.read(homeMatchingButtonViewModelProvider(_controllers,_animations).notifier).startAnimations();
    } else {
      ref.read(homeMatchingButtonViewModelProvider(_controllers,_animations).notifier).stopAnimations();
    }
    ref.watch(fcmProvider);
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(height: 115.w),
              Text(
                !matchingButton ? '매칭하기' : '상대를 찾고 있어요..',
                style: headerText1.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 68.w),
            ],
          ),
        ),
        for (int i = 0; i < _animations.length; i++)
          Center(
            child: AnimatedBuilder(
              animation: _animations[i],
              builder: (context, child) {
                return Container(
                  width: 207.0 * _animations[i].value,
                  height: 207.0 * _animations[i].value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pinkAccent.withOpacity(
                      (1.0 - (_animations[i].value - 1.0)).clamp(0.0, 1.0),
                    ),
                  ),
                );
              },
            ),
          ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              ref.read(homeMatchingButtonViewModelProvider(_controllers,_animations).notifier).toggleButton();
              if(!matchingButton){
                ref.read(homeMatchingButtonViewModelProvider(_controllers,_animations).notifier).requestMatching();
              }else{
                ref.read(homeMatchingButtonViewModelProvider(_controllers,_animations).notifier).quitMatching();
              }
            },
            style: ElevatedButton.styleFrom(shape: const CircleBorder()),
            child: Container(
              width: 207.w,
              height: 207.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: main1,
                  width: 7.0,
                ),
                color: main2,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'asset/svg/heart.svg',
                  width: 96.w,
                  height: 96.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

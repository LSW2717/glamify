import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../const/colors.dart';
import '../const/typography.dart';


class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final bool needBackButton;
  final List<Widget>? action;
  final bool extendBodyBehindAppBar;
  final bool removeAppBar;
  final bool resizeToAvoidBottomInset;
  final VoidCallback backAction;
  final Widget? bottomSheet;

  const DefaultLayout({
    this.backgroundColor = Colors.white,
    required this.child,
    this.title,
    this.bottomNavigationBar,
    this.needBackButton = false,
    this.action,
    this.extendBodyBehindAppBar = false,
    this.removeAppBar = false,
    this.resizeToAvoidBottomInset = false,
    required this.backAction,
    this.bottomSheet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: backgroundColor,
      appBar: removeAppBar ? null : renderAppBar(context),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
    );
  }

  AppBar? renderAppBar(BuildContext context) {
    return AppBar(
      shadowColor: gray100,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      toolbarHeight: 58.w,
      titleSpacing: null,
      automaticallyImplyLeading: false,
      leadingWidth: 300.w,
      leading: Row(
        children: [
          needBackButton ? Padding(
            padding: EdgeInsets.only(
              left: 0.w,
            ),
            child: IconButton(
              onPressed: () {
                  context.pop();
              },
              icon: SvgPicture.asset(
                'asset/svg/back.svg',
                width: 24.w,
                height: 24.w,
              ),
            ),
          )
              : const SizedBox(),
          title != null
              ? Padding(
            padding: EdgeInsets.only(
              left: needBackButton ? 0.w : 16.w,
            ),
            child: Text(
              title!,
              style: title == 'GLAMIFY'
                  ? headerText3.copyWith(
                fontWeight: FontWeight.w900,
              )
                  : headerText3,
            ),
          )
              : const SizedBox(),
        ],
      ),
      actions: action,
    );
  }
}

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tab_index_view_model.g.dart';

@Riverpod(keepAlive: true)
class TabIndexViewModel extends _$TabIndexViewModel {
  @override
  int build(ScrollController controller) {
    return 0;
  }

  void setIndex(int newIndex) {
    if (state == 0 && newIndex == 0) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
    state = newIndex;
  }
}
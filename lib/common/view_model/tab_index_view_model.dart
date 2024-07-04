import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tab_index_view_model.g.dart';

@Riverpod(keepAlive: true)
class TabIndexViewModel extends _$TabIndexViewModel {
  @override
  int build() {
    return 0;
  }

  void setIndex(int newIndex) {
    state = newIndex;
  }
}
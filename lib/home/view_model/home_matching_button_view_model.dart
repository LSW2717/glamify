import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../chat/repository/chat_repository.dart';

part 'home_matching_button_view_model.g.dart';

@Riverpod(keepAlive: true)
class HomeMatchingButtonViewModel extends _$HomeMatchingButtonViewModel {

  ChatRepository get chatRepository => ref.watch(chatRepositoryProvider);

  @override
  bool build(List<AnimationController> controllers,
      List<Animation<double>> animations) {
    return false;
  }

  void toggleButton() {
    state = !state;
  }

  Future<void> requestMatching() async {
    await chatRepository.requestChatWaiting();
  }

  Future<void> quitMatching() async {
    await chatRepository.quitRandomChatWaiting();
  }

  void startAnimations() {
    for (int i = 0; i < controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        controllers[i].repeat(reverse: false);
      });
    }
  }

  void stopAnimations() {
    for (var controller in controllers) {
      controller.stop();
      controller.reset();
    }
  }
}

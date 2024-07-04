import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../chat/repository/chat_repository.dart';
import '../../common/router/router.dart';

part 'home_matching_button_view_model.g.dart';

@riverpod
class HomeMatchingButtonViewModel extends _$HomeMatchingButtonViewModel {

  ChatRepository get chatRepository => ref.watch(chatRepositoryProvider);

  @override
  bool build(List<AnimationController> controllers,
      List<Animation<double>> animations) {


    ref.onDispose((){

    });
    return false;
  }
  void _onRouteChange() {
    final router = ref.read(routerProvider);
    final currentLocation  = router.routerDelegate.currentConfiguration.fullPath;
    print(currentLocation);
    if (currentLocation != '/') {
      stopButton();
    }
  }

  void toggleButton() {
    state = !state;
    if(state == true){
      startAnimations();
    }else{
      stopAnimations();
    }
  }

  void stopButton(){
    state = false;
    stopAnimations();
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
    requestMatching();
  }

  void stopAnimations() {
    for (var controller in controllers) {
      controller.stop();
      controller.reset();
    }
    quitMatching();
  }
}

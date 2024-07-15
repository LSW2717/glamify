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
  bool build() {
    return false;
  }

  void toggleButton() {
    state = !state;
    if(state == true){
      requestMatching();
    }else{
      quitMatching();
    }
  }

  void setFalse(){
    state = false;
  }


  Future<void> requestMatching() async {
    await chatRepository.requestChatWaiting();
  }

  Future<void> quitMatching() async {
    await chatRepository.quitRandomChatWaiting();
  }
}

import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

final textMessageProvider =
    StateNotifierProvider<TextMessageViewModel, types.TextMessage>((ref) {
  return TextMessageViewModel();
});

class TextMessageViewModel extends StateNotifier<types.TextMessage> {
  TextMessageViewModel()
      : super(const types.TextMessage(
          author: User(id: ''),
          id: '',
          text: '',
        ));

  void sendMessage(types.TextMessage message){
    state = message;
  }
}

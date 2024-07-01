import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/model/chat_room_response_model.dart';
import 'package:glamify/chat/repository/chat_repository.dart';
import 'package:glamify/common/model/empty_dto_model.dart';
import 'package:glamify/common/model/response_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_random_chat_view_model.g.dart';

@Riverpod(keepAlive: true)
class HomeRandomChatViewModel extends _$HomeRandomChatViewModel {

  ChatRepository get _repository => ref.watch(chatRepositoryProvider);

  @override
  HomeChatState build() {
    getRandomChatInfo();
    return const LoadingHomeChatState();
  }

  Future<void> getRandomChatInfo() async{
    try {
      final response = await _repository.getRandomChatInfo(EmptyDto());
      state = LoadedHomeChatState(response.data!.randomChatInfo!);
    } catch (e) {
      state = ErrorHomeChatState(e.toString());
    }
    print(state);
  }
}

abstract class HomeChatState {
  const HomeChatState();
}

class LoadingHomeChatState extends HomeChatState {
  const LoadingHomeChatState();
}

class LoadedHomeChatState extends HomeChatState {
  final ChatRoomResponse response;

  const LoadedHomeChatState(
    this.response,
  );
}

class ErrorHomeChatState extends HomeChatState {
  final String message;

  const ErrorHomeChatState(
    this.message,
  );
}

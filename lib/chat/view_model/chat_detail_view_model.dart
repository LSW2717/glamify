import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/model/chat_room_request_model.dart';
import 'package:glamify/chat/model/chat_room_response_model.dart';
import 'package:glamify/chat/repository/chat_repository.dart';

final chatDetailProvider =
    StateNotifierProvider<ChatDetailViewModel, ChatState>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatDetailViewModel(repository, ref);
});

class ChatDetailViewModel extends StateNotifier<ChatState> {
  final ChatRepository repository;
  final Ref ref;

  ChatDetailViewModel(
    this.repository,
    this.ref,
  ) : super(const LoadingChatState());

  Future<void> getMessageInfo(int id) async {
    state = const LoadingChatState();
    try {
      final infoRequest = ChatRoomRequest(chatRoomId: id);
      final chatInfo = await repository.getChatRoomInfo(infoRequest);
      if(chatInfo.data != null){
        state = LoadedChatState(chatInfo.data!);
      }
    } catch (e) {
      state = ErrorChatState(e.toString());
      print(e.toString());
    }
  }
}

abstract class ChatState {
  const ChatState();
}

class LoadedChatState extends ChatState {
  final ChatRoomInfoResponse infoResponse;

  const LoadedChatState(
    this.infoResponse,
  );
}

class LoadingChatState extends ChatState {
  const LoadingChatState();
}

class ErrorChatState extends ChatState {
  final String message;

  const ErrorChatState(
    this.message,
  );
}

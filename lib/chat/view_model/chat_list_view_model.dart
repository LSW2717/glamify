import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/model/chat_room_response_model.dart';
import 'package:glamify/chat/repository/chat_repository.dart';
import 'package:glamify/common/model/empty_dto_model.dart';

final chatListProvider = StateNotifierProvider<ChatListViewModel,
    ChatListState>((ref) {
      final repository = ref.watch(chatRepositoryProvider);
  return ChatListViewModel(repository);
});

class ChatListViewModel
    extends StateNotifier<ChatListState> {
  final ChatRepository repository;
  ChatListViewModel(this.repository) : super(const LoadingChatListState()){
    getChatList();
  }


  Future<void> getChatList() async{
    state = const LoadingChatListState();
    try {
      final request = EmptyDto();
      final response = await repository.getChatRoomList(request);
      print(state);
      state = LoadedChatListState(response.data!);
    } catch (e) {
      state = ErrorChatListState(e.toString());
      print(state);
      print(e.toString());
    }
  }
  Future<void> updateChatList() async{
    try {
      final request = EmptyDto();
      final response = await repository.getChatRoomList(request);
      print(state);
      state = LoadedChatListState(response.data!);
    } catch (e) {
      state = ErrorChatListState(e.toString());
      print(state);
      print(e.toString());
    }
  }
}

abstract class ChatListState {
  const ChatListState();
}

class LoadingChatListState extends ChatListState {
  const LoadingChatListState();
}

class LoadedChatListState extends ChatListState {
  final ChatRoomListResponse response;

  const LoadedChatListState(this.response);
}

class ErrorChatListState extends ChatListState {
  final String errorMessage;

  const ErrorChatListState(this.errorMessage);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/model/chat_room_request_model.dart';
import 'package:glamify/chat/model/chat_room_response_model.dart';
import 'package:glamify/chat/repository/chat_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_detail_view_model.g.dart';

@riverpod
class ChatDetailViewModel extends _$ChatDetailViewModel {

  ChatRepository get repository => ref.watch(chatRepositoryProvider);

  @override
  ChattingState build(int id) {
    getMessageInfo();
    updateMessageReadCount();
    return const LoadingChatState();
  }

  Future<void> getMessageInfo() async {
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

  Future<void> leaveChatRoom() async {
    try {
      final request = ChatRoomRequest(chatRoomId: id);
      await repository.leaveChatRoom(request);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateMessageReadCount() async{
    try {
      final request = ChatRoomRequest(chatRoomId: id);
      await repository.updateMessageReadCount(request);
    } catch (e) {
      print(e.toString());
    }
  }
}

abstract class ChattingState {
  const ChattingState();
}

class LoadedChatState extends ChattingState {
  final ChatRoomInfoResponse infoResponse;

  const LoadedChatState(
    this.infoResponse,
  );
}

class LoadingChatState extends ChattingState {
  const LoadingChatState();
}

class ErrorChatState extends ChattingState {
  final String message;

  const ErrorChatState(
    this.message,
  );
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/model/chat_room_request_model.dart';
import 'package:glamify/chat/model/chat_room_response_model.dart';
import 'package:glamify/chat/repository/chat_repository.dart';

final chatDetailProvider =
    StateNotifierProvider<ChatDetailViewModel, ChattingState>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatDetailViewModel(repository, ref);
});

class ChatDetailViewModel extends StateNotifier<ChattingState> {
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

  Future<void> leaveChatRoom(int id) async {
    try {
      final request = ChatRoomRequest(chatRoomId: id);
      await repository.leaveChatRoom(request);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateMessageReadCount(int id) async{
    try {
      final request = ChatRoomRequest(chatRoomId: id);
      await repository.updateMessageReadCount(request);
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> inviteChat(InviteChatRequest request) async{
    try {
      await repository.inviteChat(request);
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> confirmInviteChat(InvitationRequest request) async{
    try {
      await repository.confirmChatInvitation(request);
    } catch (e) {
      print(e.toString());
    }

  }
  Future<void> rejectInviteChat(InvitationRequest request) async{
    try {
      await repository.rejectChatInvitation(request);
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

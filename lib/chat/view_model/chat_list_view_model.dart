import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/model/chat_room_response_model.dart';
import 'package:glamify/chat/repository/chat_repository.dart';
import 'package:glamify/common/model/empty_dto_model.dart';
import 'package:glamify/user/view_model/user_view_model.dart';

import '../../user/model/user_model.dart';

final chatListProvider =
    StateNotifierProvider<ChatListViewModel, ChatListState>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatListViewModel(repository, ref);
});

class ChatListViewModel extends StateNotifier<ChatListState> {
  final ChatRepository repository;
  final Ref ref;

  ChatListViewModel(
    this.repository,
    this.ref,
  ) : super(const LoadingChatListState()) {
    getChatList();
  }

  Future<void> getChatList() async {
    final userState = ref.read(userViewModelProvider);
    if (userState is LoadedUserState) {
      state = const LoadingChatListState();
      try {
        final response = await repository.getChatRoomList(EmptyDto());
        print(state);
        state = LoadedChatListState(response.data!);
      } catch (e) {
        state = ErrorChatListState(e.toString());
        print(state);
        print(e.toString());
      }
    }
  }

  Future<void> updateChatList() async {
    final userState = ref.read(userViewModelProvider);
    if (userState is LoadedUserState) {
      try {
        final response = await repository.getChatRoomList(EmptyDto());
        print(state);
        state = LoadedChatListState(response.data!);
      } catch (e) {
        state = ErrorChatListState(e.toString());
        print(state);
        print(e.toString());
      }
    }
  }

  void updateChatListMessage(int chatRoomId, String message) {
    if (state is LoadedChatListState) {
      final currentState = state as LoadedChatListState;
      final updatedChatRoomList =
          currentState.response.chatRoomList.map((chatRoom) {
        if (chatRoom.chatRoomId == chatRoomId) {
          return ChatRoomResponse(
            chatRoomId: chatRoom.chatRoomId,
            ownerUserId: chatRoom.ownerUserId,
            name: chatRoom.name,
            lastMessage: message,
            messageCount: chatRoom.messageCount + 1,
            registerDate: chatRoom.registerDate,
            updateDate: DateTime.now(),
            randomYN: chatRoom.randomYN,
          );
        }
        return chatRoom;
      }).toList();

      state = LoadedChatListState(ChatRoomListResponse(
        chatRoomList: updatedChatRoomList,
        readCountList: currentState.response.readCountList,
      ));
    }
  }

  void updateChatReadCount(int chatRoomId, int messageReadCount) {
    print('호출됨');
    if (state is LoadedChatListState) {
      final currentState = state as LoadedChatListState;
      final updatedReadCountList =
          currentState.response.readCountList.map((readCount) {
        if (readCount.chatRoomId == chatRoomId) {
          print('현재리드카운트: ${readCount.messageReadCount}');
          print('받아온리드카운트: $messageReadCount');
          return ReadCountList(
              chatRoomId: chatRoomId, messageReadCount: messageReadCount);
        }
        return readCount;
      }).toList();
      print('이거이거 호출됨$state');
      state = LoadedChatListState(ChatRoomListResponse(
        chatRoomList: currentState.response.chatRoomList,
        readCountList: updatedReadCountList,
      ));
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

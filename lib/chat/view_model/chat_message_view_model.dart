import 'dart:async';
import 'dart:math';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/repository/chat_repository.dart';

import '../model/chat_message_response.dart';
import '../model/chat_room_request_model.dart';
import '../model/send_message_request_model.dart';

final chatMessageProvider =
    StateNotifierProvider<ChatMessageViewModel, List<types.Message>>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatMessageViewModel(repository);
});

class ChatMessageViewModel extends StateNotifier<List<types.Message>> {
  final ChatRepository repository;
  DateTime? lastMessageDate;
  bool isLast = false;

  ChatMessageViewModel(
    this.repository,
  ) : super([]);

  Future<void> getMessageList(int id) async {
    if(isLast){
      return;
    }
    try {
      DateTime requestDate = lastMessageDate ?? DateTime.now().toUtc();
      final request = ChatMessageListRequest(
        chatRoomId: id,
        targetDate: requestDate,
      );
      final chatMessages = await repository.getAllMessage(request);
      lastMessageDate = chatMessages.data!.messages.last.registerDate;
      final List<types.Message> messageList =
          chatMessages.data!.messages.map(toTextMessage).toList();

      for (int i = 0; i < messageList.length; i++) {
        Random random = Random();
        messageList[i] = messageList[i].copyWith(
          id: '${messageList[i].id}-${random.nextInt(1000)}',
        );
      }
      if (messageList.isNotEmpty) {
        state = [...state, ...messageList];
      }
      if(messageList.length < 30){
        isLast = true;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendMessage(String message, int chatRoomId) async {
    try {
      final request =
          SendMessageRequest(message: message, chatRoomId: chatRoomId, messageType: 'TEXT');
      await repository.sendMessage(request);
    } catch (e) {
      print(e.toString());
    }
  }

  void addMessage(types.Message message) {
    Random random = Random();
    message = message.copyWith(
      id: '${message.id}-${random.nextInt(1000)}',
    );
    state = [message, ...state];
  }

  types.TextMessage toTextMessage(Message message) {
    return types.TextMessage(
      author: types.User(id: message.userId.toString()),
      createdAt: message.registerDate.millisecondsSinceEpoch,
      id: message.chatId,
      text: message.message,
    );
  }
}

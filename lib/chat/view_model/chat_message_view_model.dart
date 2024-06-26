
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:glamify/chat/repository/chat_repository.dart';
import 'package:uuid/uuid.dart';

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

  ChatMessageViewModel(
    this.repository,
  ) : super([]);

  Future<void> getMessageList(int id) async {
    try {
      final request =
          ChatMessageListRequest(chatRoomId: id, targetDate: DateTime.now().toUtc());
      final chatMessages = await repository.getAllMessage(request);
      final List<types.Message> messageList =
      chatMessages.data!.messages.map((message) => toTextMessage(message)).toList();
      state = messageList;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendMessage(String message, int chatRoomId, String id) async {
    try {
      final request =
          SendMessageRequest(message: message, chatRoomId: chatRoomId);
      await repository.sendMessage(request);
      final text = types.PartialText(text: message);
      final textMessage = types.TextMessage(
        author: types.User(id: id),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: text.text,
      );
      // state = [textMessage,...state];
    } catch (e) {
      print(e.toString());
    }
  }
  void addMessage(types.Message message){
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

import 'dart:convert';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/view_model/text_message_view_model.dart';
import 'package:glamify/common/view_model/get_token_view_model.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../chat/model/chat_message_response.dart';
import '../data_source/data.dart';

final websocketProvider = Provider<WebSocketManager>((ref) {
  final token = ref.watch(getTokenViewModelProvider);
  return WebSocketManager(token, ref);
});

class WebSocketManager {
  final String token;
  final Ref ref;
  WebSocketChannel? _channel;

  WebSocketManager(
    this.token,
    this.ref,
  ) {
    // connect();
  }

  void connect() {
    final token = ref.watch(getTokenViewModelProvider);
    _channel = WebSocketChannel.connect(Uri.parse('$socketUrl/$token'));
    print('$socketUrl/$token');
    _channel!.stream.listen((message) {
      final Map<String, dynamic> decodedMessage = json.decode(message);
      final chatMessage = ChatMessageResponse.fromJson(decodedMessage);
      final textMessage = types.TextMessage(
        author: types.User(id: chatMessage.data.senderId.toString()),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: chatMessage.data.message,
      );
      ref.read(textMessageProvider.notifier).sendMessage(textMessage);
    });
  }

  void sendMessage(String message) {
    _channel?.sink.add(message);
  }

  void dispose() {
    _channel?.sink.close();
  }
}

import 'package:json_annotation/json_annotation.dart';
part 'chat_message_response.g.dart';

@JsonSerializable()
class MessageData {
  @JsonKey(name: 'sender_id')
  final int senderId;

  final String message;
  @JsonKey(name: 'message_type')
  final String messageType;
  @JsonKey(name: 'message_count')
  final int messageCount;
  @JsonKey(name: 'chat_room_id')
  final int chatRoomId;

  @JsonKey(name: 'chat_id')
  final String chatId;

  MessageData({
    required this.senderId,
    required this.message,
    required this.messageType,
    required this.messageCount,
    required this.chatRoomId,
    required this.chatId,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) => _$MessageDataFromJson(json);
  Map<String, dynamic> toJson() => _$MessageDataToJson(this);
}
@JsonSerializable()
class ChatReadResponse {
  @JsonKey(name: 'chat_room_id')
  final int chatRoomId;
  @JsonKey(name: 'sender_id')
  final int senderId;
  @JsonKey(name: 'message_read_count')
  final int messageReadCount;

  ChatReadResponse({
    required this.chatRoomId,
    required this.senderId,
    required this.messageReadCount,
});

factory ChatReadResponse.fromJson(Map<String, dynamic> json) => _$ChatReadResponseFromJson(json);
Map<String, dynamic> toJson() => _$ChatReadResponseToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class ChatMessageResponse<T> {
  final String channel;
  final T data;

  ChatMessageResponse({
    required this.channel,
    required this.data,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ChatMessageResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$ChatMessageResponseToJson(this, toJsonT);
}
@JsonSerializable()
class Message {
  @JsonKey(name: 'chat_id')
  final String chatId;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'register_date')
  final DateTime registerDate;

  @JsonKey(name: 'chat_room_id')
  final int chatRoomId;

  final String message;

  Message({
    required this.chatId,
    required this.userId,
    required this.registerDate,
    required this.chatRoomId,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class MessageList {
  final List<Message> messages;
  MessageList({
    required this.messages,
  });

  factory MessageList.fromJson(Map<String, dynamic> json) => _$MessageListFromJson(json);
  Map<String, dynamic> toJson() => _$MessageListToJson(this);
}
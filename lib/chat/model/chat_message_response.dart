import 'package:json_annotation/json_annotation.dart';
part 'chat_message_response.g.dart';

@JsonSerializable()
class MessageData {
  @JsonKey(name: 'sender_id')
  final int senderId;

  final String message;
  @JsonKey(name: 'chat_room_id')
  final int chatRoomId;

  MessageData({
    required this.senderId,
    required this.message,
    required this.chatRoomId,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) => _$MessageDataFromJson(json);
  Map<String, dynamic> toJson() => _$MessageDataToJson(this);
}

@JsonSerializable()
class ChatMessageResponse {
  final String channel;
  final MessageData data;

  ChatMessageResponse({
    required this.channel,
    required this.data,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) => _$ChatMessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageResponseToJson(this);
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
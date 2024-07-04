// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      senderId: (json['sender_id'] as num).toInt(),
      message: json['message'] as String,
      messageType: json['message_type'] as String,
      messageCount: (json['message_count'] as num).toInt(),
      chatRoomId: (json['chat_room_id'] as num).toInt(),
      chatId: json['chat_id'] as String,
    );

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'sender_id': instance.senderId,
      'message': instance.message,
      'message_type': instance.messageType,
      'message_count': instance.messageCount,
      'chat_room_id': instance.chatRoomId,
      'chat_id': instance.chatId,
    };

ChatReadResponse _$ChatReadResponseFromJson(Map<String, dynamic> json) =>
    ChatReadResponse(
      chatRoomId: (json['chat_room_id'] as num).toInt(),
      senderId: (json['sender_id'] as num).toInt(),
      messageReadCount: (json['message_read_count'] as num).toInt(),
    );

Map<String, dynamic> _$ChatReadResponseToJson(ChatReadResponse instance) =>
    <String, dynamic>{
      'chat_room_id': instance.chatRoomId,
      'sender_id': instance.senderId,
      'message_read_count': instance.messageReadCount,
    };

ChatMessageResponse<T> _$ChatMessageResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ChatMessageResponse<T>(
      channel: json['channel'] as String,
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$ChatMessageResponseToJson<T>(
  ChatMessageResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'channel': instance.channel,
      'data': toJsonT(instance.data),
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      chatId: json['chat_id'] as String,
      userId: (json['user_id'] as num).toInt(),
      registerDate: DateTime.parse(json['register_date'] as String),
      chatRoomId: (json['chat_room_id'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'chat_id': instance.chatId,
      'user_id': instance.userId,
      'register_date': instance.registerDate.toIso8601String(),
      'chat_room_id': instance.chatRoomId,
      'message': instance.message,
    };

MessageList _$MessageListFromJson(Map<String, dynamic> json) => MessageList(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageListToJson(MessageList instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };

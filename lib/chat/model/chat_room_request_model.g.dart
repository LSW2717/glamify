// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomRequest _$ChatRoomRequestFromJson(Map<String, dynamic> json) =>
    ChatRoomRequest(
      chatRoomId: (json['chat_room_id'] as num).toInt(),
    );

Map<String, dynamic> _$ChatRoomRequestToJson(ChatRoomRequest instance) =>
    <String, dynamic>{
      'chat_room_id': instance.chatRoomId,
    };

ChatMessageListRequest _$ChatMessageListRequestFromJson(
        Map<String, dynamic> json) =>
    ChatMessageListRequest(
      chatRoomId: (json['chat_room_id'] as num).toInt(),
      targetDate: DateTime.parse(json['target_date'] as String),
    );

Map<String, dynamic> _$ChatMessageListRequestToJson(
        ChatMessageListRequest instance) =>
    <String, dynamic>{
      'chat_room_id': instance.chatRoomId,
      'target_date': instance.targetDate.toIso8601String(),
    };

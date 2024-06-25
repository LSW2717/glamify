// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageRequest _$SendMessageRequestFromJson(Map<String, dynamic> json) =>
    SendMessageRequest(
      message: json['message'] as String,
      chatRoomId: (json['chat_room_id'] as num).toInt(),
    );

Map<String, dynamic> _$SendMessageRequestToJson(SendMessageRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'chat_room_id': instance.chatRoomId,
    };

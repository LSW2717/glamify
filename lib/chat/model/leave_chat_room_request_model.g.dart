// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_chat_room_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveChatRoomRequest _$LeaveChatRoomRequestFromJson(
        Map<String, dynamic> json) =>
    LeaveChatRoomRequest(
      chatRoomId: (json['chat_room_id'] as num).toInt(),
    );

Map<String, dynamic> _$LeaveChatRoomRequestToJson(
        LeaveChatRoomRequest instance) =>
    <String, dynamic>{
      'chat_room_id': instance.chatRoomId,
    };

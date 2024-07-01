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

InviteChatRequest _$InviteChatRequestFromJson(Map<String, dynamic> json) =>
    InviteChatRequest(
      targetId: (json['target_id'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$InviteChatRequestToJson(InviteChatRequest instance) =>
    <String, dynamic>{
      'target_id': instance.targetId,
      'message': instance.message,
    };

InvitationRequest _$InvitationRequestFromJson(Map<String, dynamic> json) =>
    InvitationRequest(
      chatInvitationId: (json['chat_invitation_id'] as num).toInt(),
    );

Map<String, dynamic> _$InvitationRequestToJson(InvitationRequest instance) =>
    <String, dynamic>{
      'chat_invitation_id': instance.chatInvitationId,
    };

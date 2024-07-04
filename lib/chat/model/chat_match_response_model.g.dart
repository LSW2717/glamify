// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_match_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMatchResponse _$ChatMatchResponseFromJson(Map<String, dynamic> json) =>
    ChatMatchResponse(
      chatRoomId: (json['chat_room_id'] as num).toInt(),
      randomYN: json['random_YN'] as String,
    );

Map<String, dynamic> _$ChatMatchResponseToJson(ChatMatchResponse instance) =>
    <String, dynamic>{
      'chat_room_id': instance.chatRoomId,
      'random_YN': instance.randomYN,
    };

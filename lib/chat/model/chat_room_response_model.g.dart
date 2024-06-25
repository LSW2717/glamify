// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomResponse _$ChatRoomResponseFromJson(Map<String, dynamic> json) =>
    ChatRoomResponse(
      chatRoomId: (json['chat_room_id'] as num).toInt(),
      ownerUserId: (json['owner_user_id'] as num).toInt(),
      registerDate: DateTime.parse(json['register_date'] as String),
      updateDate: DateTime.parse(json['update_date'] as String),
      randomYN: json['random_YN'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ChatRoomResponseToJson(ChatRoomResponse instance) =>
    <String, dynamic>{
      'chat_room_id': instance.chatRoomId,
      'owner_user_id': instance.ownerUserId,
      'register_date': instance.registerDate.toIso8601String(),
      'update_date': instance.updateDate.toIso8601String(),
      'random_YN': instance.randomYN,
      'name': instance.name,
    };

ChatRoomListResponse _$ChatRoomListResponseFromJson(
        Map<String, dynamic> json) =>
    ChatRoomListResponse(
      chatRoomList: (json['chat_room_list'] as List<dynamic>)
          .map((e) => ChatRoomResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatRoomListResponseToJson(
        ChatRoomListResponse instance) =>
    <String, dynamic>{
      'chat_room_list': instance.chatRoomList,
    };

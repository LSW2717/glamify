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
      name: json['name'] as String?,
      lastMessage: json['last_message'] as String,
      messageCount: (json['message_count'] as num).toInt(),
    );

Map<String, dynamic> _$ChatRoomResponseToJson(ChatRoomResponse instance) =>
    <String, dynamic>{
      'chat_room_id': instance.chatRoomId,
      'owner_user_id': instance.ownerUserId,
      'register_date': instance.registerDate.toIso8601String(),
      'update_date': instance.updateDate.toIso8601String(),
      'random_YN': instance.randomYN,
      'name': instance.name,
      'last_message': instance.lastMessage,
      'message_count': instance.messageCount,
    };

ChatRoomUserResponse _$ChatRoomUserResponseFromJson(
        Map<String, dynamic> json) =>
    ChatRoomUserResponse(
      userId: (json['user_id'] as num).toInt(),
      nickname: json['nickname'] as String,
      image: json['image'] as String,
      messageReadCount: (json['message_read_count'] as num).toInt(),
      updateDate: DateTime.parse(json['update_date'] as String),
    );

Map<String, dynamic> _$ChatRoomUserResponseToJson(
        ChatRoomUserResponse instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'nickname': instance.nickname,
      'image': instance.image,
      'message_read_count': instance.messageReadCount,
      'update_date': instance.updateDate.toIso8601String(),
    };

ChatRoomListResponse _$ChatRoomListResponseFromJson(
        Map<String, dynamic> json) =>
    ChatRoomListResponse(
      chatRoomList: (json['chat_room_list'] as List<dynamic>)
          .map((e) => ChatRoomResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      readCountList: (json['read_count_list'] as List<dynamic>)
          .map((e) => ReadCountList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatRoomListResponseToJson(
        ChatRoomListResponse instance) =>
    <String, dynamic>{
      'chat_room_list': instance.chatRoomList,
      'read_count_list': instance.readCountList,
    };

ChatRoomInfoResponse _$ChatRoomInfoResponseFromJson(
        Map<String, dynamic> json) =>
    ChatRoomInfoResponse(
      chatRoomInfo: ChatRoomResponse.fromJson(
          json['chat_room_info'] as Map<String, dynamic>),
      chatRoomUsers: (json['chat_room_users'] as List<dynamic>)
          .map((e) => ChatRoomUserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatRoomInfoResponseToJson(
        ChatRoomInfoResponse instance) =>
    <String, dynamic>{
      'chat_room_info': instance.chatRoomInfo,
      'chat_room_users': instance.chatRoomUsers,
    };

ReadCountList _$ReadCountListFromJson(Map<String, dynamic> json) =>
    ReadCountList(
      chatRoomId: (json['chat_room_id'] as num).toInt(),
      messageReadCount: (json['message_read_count'] as num).toInt(),
    );

Map<String, dynamic> _$ReadCountListToJson(ReadCountList instance) =>
    <String, dynamic>{
      'chat_room_id': instance.chatRoomId,
      'message_read_count': instance.messageReadCount,
    };

RandomChatInfoResponse _$RandomChatInfoResponseFromJson(
        Map<String, dynamic> json) =>
    RandomChatInfoResponse(
      randomChatInfo: json['random_chat_info'] == null
          ? null
          : ChatRoomResponse.fromJson(
              json['random_chat_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RandomChatInfoResponseToJson(
        RandomChatInfoResponse instance) =>
    <String, dynamic>{
      'random_chat_info': instance.randomChatInfo,
    };

ChatInvitationsResponse _$ChatInvitationsResponseFromJson(
        Map<String, dynamic> json) =>
    ChatInvitationsResponse(
      chatInvitations: (json['chat_invitations'] as List<dynamic>)
          .map((e) => ChatInvitation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatInvitationsResponseToJson(
        ChatInvitationsResponse instance) =>
    <String, dynamic>{
      'chat_invitations': instance.chatInvitations,
    };

ChatInvitation _$ChatInvitationFromJson(Map<String, dynamic> json) =>
    ChatInvitation(
      chatInvitationId: (json['chat_invitation_id'] as num).toInt(),
      senderId: (json['sender_id'] as num).toInt(),
      targetId: (json['target_id'] as num).toInt(),
      message: json['message'] as String,
      registerDate: DateTime.parse(json['register_date'] as String),
      updateDate: DateTime.parse(json['update_date'] as String),
    );

Map<String, dynamic> _$ChatInvitationToJson(ChatInvitation instance) =>
    <String, dynamic>{
      'chat_invitation_id': instance.chatInvitationId,
      'sender_id': instance.senderId,
      'target_id': instance.targetId,
      'message': instance.message,
      'register_date': instance.registerDate.toIso8601String(),
      'update_date': instance.updateDate.toIso8601String(),
    };

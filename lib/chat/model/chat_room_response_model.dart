import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'chat_room_response_model.g.dart';

@JsonSerializable()
class ChatRoomResponse {
  @JsonKey(name: 'chat_room_id')
  final int chatRoomId;

  @JsonKey(name: 'owner_user_id')
  final int ownerUserId;

  @JsonKey(name: 'register_date')
  final DateTime registerDate;

  @JsonKey(name: 'update_date')
  final DateTime updateDate;

  @JsonKey(name: 'random_YN')
  final String randomYN;

  final String name;

  @JsonKey(name: 'last_message')
  final String lastMessage;

  @JsonKey(name: 'message_count')
  final int messageCount;

  ChatRoomResponse({
    required this.chatRoomId,
    required this.ownerUserId,
    required this.registerDate,
    required this.updateDate,
    required this.randomYN,
    required this.name,
    required this.lastMessage,
    required this.messageCount,
  });

  factory ChatRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomResponseToJson(this);
}

@JsonSerializable()
class ChatRoomUserResponse {
  @JsonKey(name: 'user_id')
  final int userId;

  final String nickname;

  final String image;

  @JsonKey(name: 'message_read_count')
  final int messageReadCount;

  @JsonKey(name:  'update_date')
  final DateTime updateDate;

  ChatRoomUserResponse({
    required this.userId,
    required this.nickname,
    required this.image,
    required this.messageReadCount,
    required this.updateDate,
  });

  factory ChatRoomUserResponse.fromJson(Map<String, dynamic> json) => _$ChatRoomUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomUserResponseToJson(this);
}


@JsonSerializable()
class ChatRoomListResponse {
  @JsonKey(name: 'chat_room_list')
  final List<ChatRoomResponse> chatRoomList;
  @JsonKey(name: 'read_count_list')
  final List<ReadCountList> readCountList;

  ChatRoomListResponse({
    required this.chatRoomList,
    required this.readCountList,
  });

  factory ChatRoomListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomListResponseToJson(this);
}

@JsonSerializable()
class ChatRoomInfoResponse {
  @JsonKey(name: 'chat_room_info')
  final ChatRoomResponse chatRoomInfo;
  @JsonKey(name: 'chat_room_users')
  final List<ChatRoomUserResponse> chatRoomUsers;

  ChatRoomInfoResponse({
    required this.chatRoomInfo,
    required this.chatRoomUsers,
  });

  factory ChatRoomInfoResponse.fromJson(Map<String, dynamic> json) => _$ChatRoomInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomInfoResponseToJson(this);
}

@JsonSerializable()
class ReadCountList {
  @JsonKey(name: 'chat_room_id')
  final int chatRoomId;
  @JsonKey(name: 'message_read_count')
  final int messageReadCount;

  ReadCountList({
    required this.chatRoomId,
    required this.messageReadCount,
  });

  factory ReadCountList.fromJson(Map<String, dynamic> json) => _$ReadCountListFromJson(json);
  Map<String, dynamic> toJson() => _$ReadCountListToJson(this);
}

@JsonSerializable()
class RandomChatInfoResponse {
  @JsonKey(name: 'random_chat_info')
  final ChatRoomResponse? randomChatInfo;

  RandomChatInfoResponse({
    this.randomChatInfo
  });

  factory RandomChatInfoResponse.fromJson(Map<String, dynamic> json) => _$RandomChatInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RandomChatInfoResponseToJson(this);
}

@JsonSerializable()
class ChatInvitationsResponse {
  @JsonKey(name: 'chat_invitations')
  final List<ChatInvitation> chatInvitations;
  ChatInvitationsResponse({
    required this.chatInvitations,
  });

  factory ChatInvitationsResponse.fromJson(Map<String, dynamic> json) => _$ChatInvitationsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatInvitationsResponseToJson(this);
}

@JsonSerializable()
class ChatInvitation {
  @JsonKey(name: 'chat_invitation_id')
  final int chatInvitationId;
  @JsonKey(name: 'sender_id')
  final int senderId;
  @JsonKey(name: 'target_id')
  final int targetId;

  final String message;

  @JsonKey(name: 'register_date')
  final DateTime registerDate;

  @JsonKey(name: 'update_date')
  final DateTime updateDate;

  ChatInvitation({
    required this.chatInvitationId,
    required this.senderId,
    required this.targetId,
    required this.message,
    required this.registerDate,
    required this.updateDate,
  });

  factory ChatInvitation.fromJson(Map<String, dynamic> json) => _$ChatInvitationFromJson(json);
  Map<String, dynamic> toJson() => _$ChatInvitationToJson(this);
}
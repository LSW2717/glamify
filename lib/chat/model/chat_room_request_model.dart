import 'package:json_annotation/json_annotation.dart';

part 'chat_room_request_model.g.dart';

@JsonSerializable()
class ChatRoomRequest {

  @JsonKey(name: 'chat_room_id')
  final int chatRoomId;


  ChatRoomRequest({
    required this.chatRoomId,
  });

  factory ChatRoomRequest.fromJson(Map<String, dynamic> json) => _$ChatRoomRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomRequestToJson(this);
}

@JsonSerializable()
class ChatMessageListRequest {
  @JsonKey(name: 'chat_room_id')
  final int chatRoomId;

  @JsonKey(name: 'target_date')
  final DateTime targetDate;

  ChatMessageListRequest({
    required this.chatRoomId,
    required this.targetDate,
  });

  factory ChatMessageListRequest.fromJson(Map<String, dynamic> json) => _$ChatMessageListRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageListRequestToJson(this);
}

@JsonSerializable()
class InviteChatRequest {
  @JsonKey(name: 'target_id')
  final int targetId;

  final String message;

  InviteChatRequest({
    required this.targetId,
    required this.message,
  });

  factory InviteChatRequest.fromJson(Map<String, dynamic> json) => _$InviteChatRequestFromJson(json);
  Map<String, dynamic> toJson() => _$InviteChatRequestToJson(this);
}

@JsonSerializable()
class InvitationRequest {
  @JsonKey(name: 'chat_invitation_id')
  final int chatInvitationId;

  InvitationRequest({
    required this.chatInvitationId,
  });

  factory InvitationRequest.fromJson(Map<String, dynamic> json) => _$InvitationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$InvitationRequestToJson(this);
}
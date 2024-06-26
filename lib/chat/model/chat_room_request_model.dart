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
import 'package:json_annotation/json_annotation.dart';

part 'leave_chat_room_request_model.g.dart';

@JsonSerializable()
class LeaveChatRoomRequest {

  @JsonKey(name: 'chat_room_id')
  final int chatRoomId;


  LeaveChatRoomRequest({
    required this.chatRoomId,
  });

  factory LeaveChatRoomRequest.fromJson(Map<String, dynamic> json) => _$LeaveChatRoomRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveChatRoomRequestToJson(this);
}
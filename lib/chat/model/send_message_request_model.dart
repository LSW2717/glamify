import 'package:json_annotation/json_annotation.dart';

part 'send_message_request_model.g.dart';

@JsonSerializable()
class SendMessageRequest {
  final String message;

  @JsonKey(name:'chat_room_id')
  final int chatRoomId;

  SendMessageRequest({
    required this.message,
    required this.chatRoomId,
  });

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) => _$SendMessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SendMessageRequestToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'send_message_request_model.g.dart';

@JsonSerializable()
class SendMessageRequest {
  final String message;

  @JsonKey(name:'chat_room_id')
  final int chatRoomId;

  @JsonKey(name: 'message_type')
  final String messageType;

  SendMessageRequest({
    required this.message,
    required this.chatRoomId,
    required this.messageType,
  });

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) => _$SendMessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SendMessageRequestToJson(this);
}
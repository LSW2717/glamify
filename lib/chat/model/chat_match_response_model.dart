import 'package:json_annotation/json_annotation.dart';

part 'chat_match_response_model.g.dart';

@JsonSerializable()
class ChatMatchResponse {
  @JsonKey(name: 'chat_room_id')
  final int chatRoomId;
  @JsonKey(name: 'random_YN')
  final String randomYN;
  ChatMatchResponse({
    required this.chatRoomId,
    required this.randomYN,
  });

  factory ChatMatchResponse.fromJson(Map<String, dynamic> json) => _$ChatMatchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMatchResponseToJson(this);
}
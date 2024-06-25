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

  ChatRoomResponse({
    required this.chatRoomId,
    required this.ownerUserId,
    required this.registerDate,
    required this.updateDate,
    required this.randomYN,
    required this.name,
  });

  factory ChatRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomResponseToJson(this);
}

@JsonSerializable()
class ChatRoomListResponse {
  @JsonKey(name: 'chat_room_list')
  final List<ChatRoomResponse> chatRoomList;

  ChatRoomListResponse({
    required this.chatRoomList,
  });

  factory ChatRoomListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomListResponseToJson(this);
}

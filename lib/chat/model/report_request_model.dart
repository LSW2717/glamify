import 'package:json_annotation/json_annotation.dart';

part 'report_request_model.g.dart';


@JsonSerializable()
class ReportRequest {

  @JsonKey(name: 'chat_room_id')
  final int chatRoomId;

  @JsonKey(name: 'user_id')
  final int userId;
  final String message;

  ReportRequest({
    required this.chatRoomId,
    required this.userId,
    required this.message,
  });

  factory ReportRequest.fromJson(Map<String, dynamic> json) => _$ReportRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ReportRequestToJson(this);
}
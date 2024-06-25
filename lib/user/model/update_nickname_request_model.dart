import 'package:json_annotation/json_annotation.dart';

part 'update_nickname_request_model.g.dart';

@JsonSerializable()
class UpdateNicknameRequest {
  final String nickname;
  UpdateNicknameRequest({
    required this.nickname,
  });

  factory UpdateNicknameRequest.fromJson(Map<String, dynamic> json) => _$UpdateNicknameRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateNicknameRequestToJson(this);
}
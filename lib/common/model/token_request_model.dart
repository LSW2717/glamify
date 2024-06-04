import 'package:json_annotation/json_annotation.dart';

part 'token_request_model.g.dart';

@JsonSerializable()
class TokenRequest {
  String token;

  TokenRequest({
    required this.token,
  });

  factory TokenRequest.fromJson(Map<String, dynamic> json) => _$TokenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TokenRequestToJson(this);
}
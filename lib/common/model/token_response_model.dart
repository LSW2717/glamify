import 'package:json_annotation/json_annotation.dart';

part 'token_response_model.g.dart';

@JsonSerializable()
class TokenResponse {
  String accessToken;
  String refreshToken;

  TokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
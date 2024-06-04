import 'package:json_annotation/json_annotation.dart';
part 'fcm_token_request_model.g.dart';

@JsonSerializable()
class FcmTokenRequest {

  @JsonKey(name: 'push_notification_token')
  String pushNotificationToken;

  FcmTokenRequest({
    required this.pushNotificationToken,
  });

  factory FcmTokenRequest.fromJson(Map<String, dynamic> json) => _$FcmTokenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FcmTokenRequestToJson(this);
}
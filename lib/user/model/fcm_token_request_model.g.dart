// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_token_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmTokenRequest _$FcmTokenRequestFromJson(Map<String, dynamic> json) =>
    FcmTokenRequest(
      pushNotificationToken: json['push_notification_token'] as String,
    );

Map<String, dynamic> _$FcmTokenRequestToJson(FcmTokenRequest instance) =>
    <String, dynamic>{
      'push_notification_token': instance.pushNotificationToken,
    };

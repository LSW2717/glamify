// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadedUserState _$LoadedUserStateFromJson(Map<String, dynamic> json) =>
    LoadedUserState(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoadedUserStateToJson(LoadedUserState instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: (json['user_id'] as num).toInt(),
      nickname: json['nickname'] as String,
      email: json['e_mail'] as String,
      image: json['image'] as String,
      phoneNumber: json['phone_number'] as String?,
      refreshToken: json['refresh_token'] as String,
      pushNotificationToken: json['push_notification_token'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.userId,
      'nickname': instance.nickname,
      'e_mail': instance.email,
      'image': instance.image,
      'phone_number': instance.phoneNumber,
      'refresh_token': instance.refreshToken,
      'push_notification_token': instance.pushNotificationToken,
    };

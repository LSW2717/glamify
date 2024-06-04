// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadedUserState _$LoadedUserStateFromJson(Map<String, dynamic> json) =>
    LoadedUserState(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoadedUserStateToJson(LoadedUserState instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: (json['userId'] as num).toInt(),
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      refreshToken: json['refreshToken'] as String,
      pushNoticeToken: json['pushNoticeToken'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'email': instance.email,
      'image': instance.image,
      'phoneNumber': instance.phoneNumber,
      'refreshToken': instance.refreshToken,
      'pushNoticeToken': instance.pushNoticeToken,
    };

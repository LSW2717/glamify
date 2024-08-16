import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

abstract class UserState {}

class ErrorUserState extends UserState {
  final String message;

  ErrorUserState({
    required this.message,
  });
}

class InitUserState extends UserState {}

class LoadingUserState extends UserState {}

@JsonSerializable()
class LoadedUserState extends UserState{
  final UserModel user;

  LoadedUserState({
    required this.user,
  });

  factory LoadedUserState.fromJson(Map<String, dynamic> json) =>
      _$LoadedUserStateFromJson(json);

  Map<String, dynamic> toJson() => _$LoadedUserStateToJson(this);
}

@JsonSerializable()
class UserModel {

  @JsonKey(name: 'user_id')
  final int userId;

  final String nickname;

  @JsonKey(name: 'e_mail')
  final String email;
  final String image;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(name: 'push_notification_token')
  final String pushNotificationToken;

  @JsonKey(name: 'push_notification_agreement_YN')
  final String pushNotificationAgreement;

  @JsonKey(name: 'permission_type')
  final String permissionType;

  UserModel({
    required this.userId,
    required this.nickname,
    required this.email,
    required this.image,
    this.phoneNumber,
    required this.refreshToken,
    required this.pushNotificationToken,
    required this.pushNotificationAgreement,
    required this.permissionType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
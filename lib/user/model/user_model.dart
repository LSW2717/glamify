import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

abstract class UserState {}

class ErrorUserState extends UserState {
  final String message;

  ErrorUserState({
    required this.message,
  });
}

class LoadingUserState extends UserState {}

@JsonSerializable()
class LoadedUserState extends UserState{
  final User user;

  LoadedUserState({
    required this.user,
  });

  factory LoadedUserState.fromJson(Map<String, dynamic> json) =>
      _$LoadedUserStateFromJson(json);

  Map<String, dynamic> toJson() => _$LoadedUserStateToJson(this);
}

@JsonSerializable()
class User {
  final int userId;
  final String nickname;
  final String email;
  final String image;
  final String? phoneNumber;
  final String refreshToken;
  final String pushNoticeToken;

  User({
    required this.userId,
    required this.nickname,
    required this.email,
    required this.image,
    this.phoneNumber,
    required this.refreshToken,
    required this.pushNoticeToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
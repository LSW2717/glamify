import 'package:json_annotation/json_annotation.dart';

part 'update_profile_image_request_model.g.dart';


@JsonSerializable()
class UpdateProfileImageRequest{

  @JsonKey(name: 'profile_image_uri')
  final String profileImageUri;

  UpdateProfileImageRequest({
    required this.profileImageUri,
  });

  factory UpdateProfileImageRequest.fromJson(Map<String, dynamic> json) => _$UpdateProfileImageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProfileImageRequestToJson(this);
}
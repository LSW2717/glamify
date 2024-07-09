import 'package:json_annotation/json_annotation.dart';

part 'image_request.g.dart';

@JsonSerializable()
class ImageRequest {

  @JsonKey(name: 'is_profile')
  final bool isProfile;

  ImageRequest({
    required this.isProfile,
  });

  factory ImageRequest.fromJson(Map<String, dynamic> json) => _$ImageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ImageRequestToJson(this);
}
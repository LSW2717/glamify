import 'package:json_annotation/json_annotation.dart';

part 'image_response.g.dart';

@JsonSerializable()
class ImageResponse {

  @JsonKey(name: 'upload_uri')
  final String uploadUri;

  @JsonKey(name: 'load_uri')
  final String loadUri;

  ImageResponse({
    required this.uploadUri,
    required this.loadUri,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) => _$ImageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);
}
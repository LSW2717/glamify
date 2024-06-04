import 'package:json_annotation/json_annotation.dart';
part 'response_dto.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseDto<T> {
  final String message;
  final T? data;
  final int code;

  ResponseDto({
    required this.message,
    this.data,
    required this.code,
  });

  factory ResponseDto.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResponseDtoFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ResponseDtoToJson(this, toJsonT);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDto<T> _$ResponseDtoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResponseDto<T>(
      message: json['message'] as String,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$ResponseDtoToJson<T>(
  ResponseDto<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'message': instance.message,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'code': instance.code,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

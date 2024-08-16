// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skip_and_limit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkipAndLimit _$SkipAndLimitFromJson(Map<String, dynamic> json) => SkipAndLimit(
      skip: (json['skip'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$SkipAndLimitToJson(SkipAndLimit instance) =>
    <String, dynamic>{
      'skip': instance.skip,
      'limit': instance.limit,
    };

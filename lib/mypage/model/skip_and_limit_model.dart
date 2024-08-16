import 'package:json_annotation/json_annotation.dart';

part 'skip_and_limit_model.g.dart';


@JsonSerializable()
class SkipAndLimit {
  
  final int skip;
  final int limit;
  
  SkipAndLimit({
    required this.skip,
    required this.limit,
  });

  factory SkipAndLimit.fromJson(Map<String, dynamic> json) => _$SkipAndLimitFromJson(json);
  Map<String, dynamic> toJson() => _$SkipAndLimitToJson(this);
}
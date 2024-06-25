import 'package:json_annotation/json_annotation.dart';

part 'empty_dto_model.g.dart';

@JsonSerializable()
class EmptyDto {

  EmptyDto();

  factory EmptyDto.fromJson(Map<String, dynamic> json) => _$EmptyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EmptyDtoToJson(this);
}
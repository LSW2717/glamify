import 'package:json_annotation/json_annotation.dart';
part 'dummy.g.dart';

@JsonSerializable()
class Dummy {
  final int? dummy;
  Dummy({
    this.dummy,
  });

  factory Dummy.fromJson(Map<String, dynamic> json) => _$DummyFromJson(json);
  Map<String, dynamic> toJson() => _$DummyToJson(this);
}
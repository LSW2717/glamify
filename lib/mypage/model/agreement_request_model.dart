import 'package:json_annotation/json_annotation.dart';

part 'agreement_request_model.g.dart';


@JsonSerializable()
class AgreementRequest {
  final String agreement;
  AgreementRequest({
    required this.agreement,
  });

  factory AgreementRequest.fromJson(Map<String, dynamic> json) => _$AgreementRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AgreementRequestToJson(this);
}
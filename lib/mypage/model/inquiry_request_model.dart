import 'package:json_annotation/json_annotation.dart';

part 'inquiry_request_model.g.dart';


@JsonSerializable()
class InquiryRequest {
  final String title;
  final String description;

  InquiryRequest({
    required this.title,
    required this.description,
  });

  factory InquiryRequest.fromJson(Map<String, dynamic> json) => _$InquiryRequestFromJson(json);
  Map<String, dynamic> toJson() => _$InquiryRequestToJson(this);
}
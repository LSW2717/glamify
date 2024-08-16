import 'package:json_annotation/json_annotation.dart';

part 'inquiry_response_model.g.dart';

@JsonSerializable()
class InquiryResponse {
  final List<InquiryDescriptionResponse> inquiries;
  final int total;

  InquiryResponse({
    required this.inquiries,
    required this.total,
  });

  factory InquiryResponse.fromJson(Map<String, dynamic> json) =>
      _$InquiryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InquiryResponseToJson(this);
}

@JsonSerializable()
class InquiryDescriptionResponse {
  @JsonKey(name: 'inquiry_id')
  final int inquiryId;

  @JsonKey(name: 'user_id')
  final int userId;

  final String title;

  final String description;

  @JsonKey(name: 'update_date')
  final DateTime updateDate;

  @JsonKey(name: 'register_date')
  final DateTime registerDate;

  @JsonKey(name: 'inquiry_answers')
  final List<InquiryAnswersResponse> inquiryAnswers;

  InquiryDescriptionResponse({
    required this.inquiryId,
    required this.userId,
    required this.title,
    required this.description,
    required this.updateDate,
    required this.registerDate,
    required this.inquiryAnswers,
  });

  factory InquiryDescriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$InquiryDescriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InquiryDescriptionResponseToJson(this);
}

@JsonSerializable()
class InquiryAnswersResponse {
  @JsonKey(name: 'inquiry_answer_id')
  final int inquiryAnswerId;
  @JsonKey(name: 'inquiry_id')
  final int inquiryId;
  @JsonKey(name: 'writer_id')
  final int writerId;
  final String description;

  @JsonKey(name: 'update_date')
  final DateTime updateDate;

  @JsonKey(name: 'register_date')
  final DateTime registerDate;

  InquiryAnswersResponse({
    required this.inquiryAnswerId,
    required this.inquiryId,
    required this.writerId,
    required this.description,
    required this.updateDate,
    required this.registerDate,
  });

  factory InquiryAnswersResponse.fromJson(Map<String, dynamic> json) =>
      _$InquiryAnswersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InquiryAnswersResponseToJson(this);
}

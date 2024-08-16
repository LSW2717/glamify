// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquiry_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InquiryResponse _$InquiryResponseFromJson(Map<String, dynamic> json) =>
    InquiryResponse(
      inquiries: (json['inquiries'] as List<dynamic>)
          .map((e) =>
              InquiryDescriptionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$InquiryResponseToJson(InquiryResponse instance) =>
    <String, dynamic>{
      'inquiries': instance.inquiries,
      'total': instance.total,
    };

InquiryDescriptionResponse _$InquiryDescriptionResponseFromJson(
        Map<String, dynamic> json) =>
    InquiryDescriptionResponse(
      inquiryId: (json['inquiry_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      updateDate: DateTime.parse(json['update_date'] as String),
      registerDate: DateTime.parse(json['register_date'] as String),
      inquiryAnswers: (json['inquiry_answers'] as List<dynamic>)
          .map(
              (e) => InquiryAnswersResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InquiryDescriptionResponseToJson(
        InquiryDescriptionResponse instance) =>
    <String, dynamic>{
      'inquiry_id': instance.inquiryId,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'update_date': instance.updateDate.toIso8601String(),
      'register_date': instance.registerDate.toIso8601String(),
      'inquiry_answers': instance.inquiryAnswers,
    };

InquiryAnswersResponse _$InquiryAnswersResponseFromJson(
        Map<String, dynamic> json) =>
    InquiryAnswersResponse(
      inquiryAnswerId: (json['inquiry_answer_id'] as num).toInt(),
      inquiryId: (json['inquiry_id'] as num).toInt(),
      writerId: (json['writer_id'] as num).toInt(),
      description: json['description'] as String,
      updateDate: DateTime.parse(json['update_date'] as String),
      registerDate: DateTime.parse(json['register_date'] as String),
    );

Map<String, dynamic> _$InquiryAnswersResponseToJson(
        InquiryAnswersResponse instance) =>
    <String, dynamic>{
      'inquiry_answer_id': instance.inquiryAnswerId,
      'inquiry_id': instance.inquiryId,
      'writer_id': instance.writerId,
      'description': instance.description,
      'update_date': instance.updateDate.toIso8601String(),
      'register_date': instance.registerDate.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquiry_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InquiryRequest _$InquiryRequestFromJson(Map<String, dynamic> json) =>
    InquiryRequest(
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$InquiryRequestToJson(InquiryRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportRequest _$ReportRequestFromJson(Map<String, dynamic> json) =>
    ReportRequest(
      chatRoomId: (json['chat_room_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$ReportRequestToJson(ReportRequest instance) =>
    <String, dynamic>{
      'chat_room_id': instance.chatRoomId,
      'user_id': instance.userId,
      'message': instance.message,
    };

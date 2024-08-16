import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/cupertino.dart';
import 'package:glamify/chat/model/report_request_model.dart';
import 'package:glamify/common/dio/dio.dart';
import 'package:glamify/common/model/empty_dto_model.dart';
import 'package:glamify/mypage/model/inquiry_response_model.dart';
import 'package:glamify/mypage/model/skip_and_limit_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/data_source/data.dart';
import '../../common/model/response_dto.dart';
import '../model/inquiry_request_model.dart';

part 'report_repository.g.dart';


@riverpod
ReportRepository reportRepository(ReportRepositoryRef ref) {
  final dio = ref.watch(dioProvider);

  return ReportRepository(dio, baseUrl: 'http://$ip/v1/report');
}

@RestApi()
abstract class ReportRepository{
  factory ReportRepository(Dio dio, {String baseUrl}) = _ReportRepository;


  @POST('/complain_criminal_chat')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> complainCriminalChat(@Body() ReportRequest request);

  @POST('/send_inquiry')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> sendInquiry(@Body() InquiryRequest request);

  @POST('/get_inquiries')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<InquiryResponse>> getInquiries(@Body() SkipAndLimit request);
}

import 'package:dio/dio.dart' hide Headers;
import 'package:glamify/chat/model/report_request_model.dart';
import 'package:glamify/common/model/empty_dto_model.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/data_source/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/response_dto.dart';

part 'report_repository.g.dart';


@Riverpod(keepAlive: true)
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

}

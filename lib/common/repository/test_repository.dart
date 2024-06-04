import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../model/dummy.dart';
import '../data_source/data.dart';
import '../model/response_dto.dart';
part 'test_repository.g.dart';

final testRepositoryProvider = Provider<TestRepository>((ref) {
  final dio = Dio();
  return TestRepository(dio, baseUrl: 'http://$ip/v1/test');
});


@RestApi()
abstract class TestRepository{
  factory TestRepository(Dio dio, {String baseUrl}) = _TestRepository;



  @GET('/health_check')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<Dummy>> getHealthCheck();


  @POST('/health_check')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<Dummy>> postHealthCheck(@Body() Dummy dummy);



}

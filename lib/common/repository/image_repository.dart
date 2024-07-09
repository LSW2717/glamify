import 'package:dio/dio.dart' hide Headers;
import 'package:glamify/common/model/image_request.dart';
import 'package:glamify/common/model/image_response.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data_source/data.dart';
import '../dio/dio.dart';
import '../model/response_dto.dart';

part 'image_repository.g.dart';

@Riverpod(keepAlive: true)
ImageRepository imageRepository(ImageRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return ImageRepository(dio, baseUrl: 'http://$ip/v1/file');
}

@RestApi()
abstract class ImageRepository{
  factory ImageRepository(Dio dio, {String baseUrl}) = _ImageRepository;

  @POST('/get_upload_image_url')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<ImageResponse>> getUploadImageUri(@Body() ImageRequest request);
}

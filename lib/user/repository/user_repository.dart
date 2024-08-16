import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/common/model/empty_dto_model.dart';
import 'package:glamify/common/model/token_response_model.dart';
import 'package:glamify/mypage/model/agreement_request_model.dart';
import 'package:glamify/mypage/model/update_profile_image_request_model.dart';
import 'package:glamify/user/model/update_nickname_request_model.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/data_source/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/response_dto.dart';
import '../model/fcm_token_request_model.dart';
import '../model/user_model.dart';

part 'user_repository.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio, baseUrl: 'http://$ip/v1');
}

@RestApi()
abstract class UserRepository{
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @GET('/user/get_user_info')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<LoadedUserState>> getUserInfo();

  @POST('/user/update_push_notification_token')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> updateFcmToken(@Body() FcmTokenRequest request);

  @POST('/auth/reissue')
  @Headers({
    'refreshToken': 'true'
  })
  Future<ResponseDto<TokenResponse>> reissue();

  @POST('/user/update_nickname')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> updateNickname(@Body() UpdateNicknameRequest request);
  
  @POST('/user/unsubscribe')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> unsubscribe(@Body() EmptyDto request);

  @POST('/auth/logout')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> logout(@Body() EmptyDto request);

  @POST('/user/update_push_notification_agreement')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> updateNotificationAgreement(@Body() AgreementRequest request);

  @POST('/user/update_profile_image')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> updateProfileImage(@Body() UpdateProfileImageRequest request);
}





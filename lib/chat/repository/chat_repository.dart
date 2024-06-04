import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/common/dio/dio.dart';
import 'package:glamify/common/model/empty_response_model.dart';
import 'package:glamify/common/model/response_dto.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/data_source/data.dart';
import '../../common/model/token_request_model.dart';

part 'chat_repository.g.dart';

@Riverpod(keepAlive: true)
ChatRepository chatRepository(ChatRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return ChatRepository(dio, baseUrl: 'http://$ip/v1/chat');
}

@RestApi()
abstract class ChatRepository{
  factory ChatRepository(Dio dio, {String baseUrl}) = _ChatRepository;

  @POST('/request_random_chat_waiting')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyResponse>> requestChatWaiting();

  @POST('/leave_random_chat_room')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyResponse>> leaveRandomChatRoom(@Body() TokenRequest request);


 /* @POST('/send_push_message')
  @Headers({
    'accessToken': 'true',
  })
  Future<>
*/
  @POST('/quit_random_chat_waiting')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyResponse>> quitRandomChatWaiting();




}

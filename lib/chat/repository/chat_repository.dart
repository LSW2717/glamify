import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/model/chat_room_response_model.dart';
import 'package:glamify/chat/model/leave_chat_room_request_model.dart';
import 'package:glamify/chat/model/send_message_request_model.dart';
import 'package:glamify/common/dio/dio.dart';
import 'package:glamify/common/model/empty_dto_model.dart';
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
  Future<ResponseDto<EmptyDto>> requestChatWaiting();

  @POST('/quit_random_chat_waiting')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> quitRandomChatWaiting();



  @POST('/leave_chat_room')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> leaveChatRoom(@Body() LeaveChatRoomRequest request);


  @POST('/send_message')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> sendMessage(@Body() SendMessageRequest request);

  @POST('/get_chat_room_list')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<ChatRoomListResponse>> getChatRoomList(@Body() EmptyDto request);


}

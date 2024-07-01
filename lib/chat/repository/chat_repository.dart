import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/model/chat_room_response_model.dart';
import 'package:glamify/chat/model/chat_room_request_model.dart';
import 'package:glamify/chat/model/send_message_request_model.dart';
import 'package:glamify/common/dio/dio.dart';
import 'package:glamify/common/model/empty_dto_model.dart';
import 'package:glamify/common/model/response_dto.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/data_source/data.dart';
import '../../common/model/token_request_model.dart';
import '../model/chat_message_response.dart';

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
  Future<ResponseDto<EmptyDto>> leaveChatRoom(@Body() ChatRoomRequest request);


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

  @POST('/get_chat_room_info')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<ChatRoomInfoResponse>> getChatRoomInfo(@Body() ChatRoomRequest request);

  @POST('/get_message')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<MessageList>> getAllMessage(@Body() ChatMessageListRequest request);

  @POST('/get_random_chat_info')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<RandomChatInfoResponse>> getRandomChatInfo(@Body() EmptyDto request);

  @POST('/update_message_read_count')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> updateMessageReadCount(@Body() ChatRoomRequest request);

  @POST('/invite_chat')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> inviteChat(@Body() InviteChatRequest request);

  @POST('/get_chat_invitation')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<ChatInvitationsResponse>> getChatInvitation(@Body() EmptyDto request);

  @POST('/confirm_chat_invitation')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> confirmChatInvitation(@Body() InvitationRequest request);

  @POST('/reject_chat_invitation')
  @Headers({
    'accessToken': 'true',
  })
  Future<ResponseDto<EmptyDto>> rejectChatInvitation(@Body() InvitationRequest request);

}

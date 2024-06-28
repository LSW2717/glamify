import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../chat/model/chat_message_response.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';
const PROVIDER = 'PROVIDER';
const APP_REDIRECT_URI = 'dating.batro.org';

const FCM_TOKEN_KEY = 'FCM_TOKEN';


const ip = 'dating.batro.org:4000';

const socketUrl = 'ws://dating.batro.org:4000/ws';

types.TextMessage toTextMessage(Message message) {
  return types.TextMessage(
    author: types.User(id: message.userId.toString()),
    createdAt: message.registerDate.millisecondsSinceEpoch,
    id: message.chatId,
    text: message.message,
  );
}
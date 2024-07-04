import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/chat/repository/chat_repository.dart';
import 'package:glamify/common/global_variable/global_variable.dart';
import 'package:glamify/home/view_model/home_random_chat_view_model.dart';
import 'package:glamify/user/model/user_model.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../common/data_source/data.dart';
import '../../common/view_model/get_token_view_model.dart';
import '../model/chat_match_response_model.dart';
import '../model/chat_message_response.dart';
import '../model/chat_room_request_model.dart';
import '../model/send_message_request_model.dart';
import 'chat_detail_view_model.dart';
import 'chat_list_view_model.dart';

part 'chat_message_view_model.g.dart';

// final chatMessageProvider =
//     StateNotifierProvider<ChatMessageViewModel, List<types.Message>>((ref) {
//   final token = ref.read(getTokenViewModelProvider);
//   final WebSocketChannel channel =
//       WebSocketChannel.connect(Uri.parse('$socketUrl/$token'));
//   final repository = ref.watch(chatRepositoryProvider);
//   ref.onDispose(() {
//     channel.sink.close();
//   });
//   return ChatMessageViewModel(repository, ref, channel);
// });
//
// class ChatMessageViewModel extends StateNotifier<List<types.Message>> {
//   final ChatRepository repository;
//   final Ref ref;
//   final WebSocketChannel channel;
//   int? chatRoomId;
//   DateTime? lastMessageDate;
//   bool isLast = false;
//   int page = 0;
//   int? totalCount;
//   Map<int, int> readCountMap = {};
//
//   ChatMessageViewModel(
//     this.repository,
//     this.ref,
//     this.channel,
//   ) : super([]) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         listener();
//       }
//     });
//   }
//
//   Future<void> getMessageList(int chatRoomId) async {
//     if (isLast) {
//       return;
//     }
//     try {
//       final chatState = ref.read(chatDetailProvider);
//       if (chatState is LoadedChatState) {
//         final chatData = chatState.infoResponse;
//
//         DateTime requestDate = lastMessageDate ?? DateTime.now().toUtc();
//         final request = ChatMessageListRequest(
//           chatRoomId: chatRoomId,
//           targetDate: requestDate,
//         );
//         final chatMessages = await repository.getAllMessage(request);
//         lastMessageDate = chatMessages.data!.messages.last.registerDate;
//
//         totalCount = chatData.chatRoomInfo.messageCount;
//         //각 룸마다 맴버별 readCount 추가
//         for (var user in chatData.chatRoomUsers) {
//           readCountMap[user.userId] =
//               totalCount! - user.messageReadCount - page * 30;
//         }
//
//         //type.Message로 변환
//         final List<types.Message> messageList =
//             chatMessages.data!.messages.map(toTextMessage).toList();
//
//         //각 메세지에 readMember넣어줌
//         for (var i = 0; i < messageList.length; i++) {
//           List<int> readMembers = [];
//           for (var entry in readCountMap.entries) {
//             if (i >= entry.value) {
//               readMembers.add(entry.key);
//             }
//           }
//           messageList[i] = messageList[i].copyWith(metadata: {
//             ...messageList[i].metadata!,
//             'readMember': readMembers,
//           });
//         }
//
//         //각 메세지마다 랜덤넘버 부여
//         for (int i = 0; i < messageList.length; i++) {
//           Random random = Random();
//           messageList[i] = messageList[i].copyWith(
//             id: '${messageList[i].id}-${random.nextInt(1000)}',
//           );
//         }
//
//         //메세지가 없거나 30개 이하면 마지막페이지
//         if (messageList.length < 30 || messageList.isEmpty) {
//           isLast = true;
//         }
//         if (messageList.isNotEmpty) {
//           state = [...state, ...messageList];
//         }
//         page++;
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future<void> sendMessage(String message, int chatRoomId) async {
//     try {
//       final request = SendMessageRequest(
//           message: message, chatRoomId: chatRoomId, messageType: 'TEXT');
//       await repository.sendMessage(request);
//       addMessage(message, chatRoomId);
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   void addMessage(String message, int chatRoomId) {
//     var now = DateTime.now().millisecondsSinceEpoch;
//     var uniqueId = Uuid().v4();
//     var random = Random().nextInt(100000);
//     final userState = ref.read(userViewModelProvider);
//     if (userState is LoadedUserState) {
//       final textMessage = types.TextMessage(
//         author: types.User(id: userState.user.userId.toString()),
//         createdAt: DateTime.now().millisecondsSinceEpoch,
//         id: '$now - $uniqueId - $random',
//         text: message,
//         metadata: const {'readMember': []},
//       );
//       ref.read(chatDetailProvider.notifier).updateMessageReadCount(chatRoomId);
//       state = [textMessage, ...state];
//     }
//   }
//
//   void setRoomId(int id) {
//     chatRoomId = id;
//   }
//
//   void listener() {
//     if (mounted) {
//       channel.stream.listen((message) {
//         print(message);
//         final Map<String, dynamic> decodedMessage = json.decode(message);
//         final channel = decodedMessage['channel'] as String;
//         final userState = ref.watch(userViewModelProvider);
//         final chatState = ref.watch(chatDetailProvider);
//         print(chatRoomId);
//         if (userState is LoadedUserState) {
//           if (channel == 'CHAT_READ') {
//             final chatReadResponse =
//                 ChatReadResponse.fromJson(decodedMessage['data']);
//             print('룸아이디: ${chatReadResponse.chatRoomId}');
//             print('보낸사람아이디: ${chatReadResponse.senderId}');
//             print('메세지 리드카운트: ${chatReadResponse.messageReadCount}');
//             updateReadStatus(
//                 chatReadResponse.chatRoomId, chatReadResponse.senderId);
//           }
//           if (channel == 'CHAT') {
//             final chatMessage = ChatMessageResponse<MessageData>.fromJson(
//               decodedMessage,
//               (json) => MessageData.fromJson(json as Map<String, dynamic>),
//             );
//             print('이거이거좀 되라${chatMessage.data.chatId}');
//             print('이거좀되라$chatMessage');
//             ref.read(chatListProvider.notifier).updateChatListMessage(
//                   chatMessage.data.chatRoomId,
//                   chatMessage.data.message,
//                 );
//             if (chatRoomId == chatMessage.data.chatRoomId) {
//               if (mounted) {
//                 totalCount = chatMessage.data.messageCount;
//                 if (userState.user.userId != chatMessage.data.senderId) {
//                   ref
//                       .read(chatDetailProvider.notifier)
//                       .updateMessageReadCount(chatMessage.data.chatRoomId);
//                   var random = Random().nextInt(100000);
//                   final textMessage = types.TextMessage(
//                     author:
//                         types.User(id: chatMessage.data.senderId.toString()),
//                     createdAt: DateTime.now().millisecondsSinceEpoch,
//                     id: '${chatMessage.data.chatId} - $random',
//                     text: chatMessage.data.message,
//                   );
//                   state = [textMessage, ...state];
//                 }
//               }
//             }
//           }
//         }
//       });
//     }
//   }
//
//   void updateReadStatus(int chatRoomId, int userId) {
//     state = state.map((message) {
//       if (message.metadata != null &&
//           message.metadata!['readMember'] != null &&
//           !message.metadata!['readMember'].contains(userId)) {
//         List<int> readMember = List<int>.from(message.metadata!['readMember']);
//         readMember.add(userId);
//         return message.copyWith(metadata: {
//           ...message.metadata!,
//           'readMember': readMember,
//         });
//       }
//       return message;
//     }).toList();
//   }
//
//   types.TextMessage toTextMessage(Message message) {
//     return types.TextMessage(
//       author: types.User(id: message.userId.toString()),
//       createdAt: message.registerDate.millisecondsSinceEpoch,
//       id: message.chatId,
//       text: message.message,
//       metadata: const {'readMember': []},
//     );
//   }
// }

@riverpod
class ChatMessageViewModel extends _$ChatMessageViewModel {
  late WebSocketChannel channel;

  ChatRepository get repository => ref.watch(chatRepositoryProvider);

  String get token => ref.watch(getTokenViewModelProvider);
  DateTime? lastMessageDate;
  bool isLast = false;
  int page = 0;
  int? totalCount;
  Map<int, int> readCountMap = {};

  @override
  List<types.Message> build(int chatRoomId) {
    channel = WebSocketChannel.connect(Uri.parse('$socketUrl/$token'));
    getMessageList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      listener();
    });
    return [];
  }

  Future<void> getMessageList() async {
    if (isLast) {
      return;
    }
    try {
      final chatState = ref.read(chatDetailProvider);
      if (chatState is LoadedChatState) {
        final chatData = chatState.infoResponse;

        DateTime requestDate = lastMessageDate ?? DateTime.now().toUtc();
        final request = ChatMessageListRequest(
          chatRoomId: chatRoomId,
          targetDate: requestDate,
        );
        final chatMessages = await repository.getAllMessage(request);
        lastMessageDate = chatMessages.data!.messages.last.registerDate;

        totalCount = chatData.chatRoomInfo.messageCount;
        //각 룸마다 맴버별 readCount 추가
        for (var user in chatData.chatRoomUsers) {
          readCountMap[user.userId] =
              totalCount! - user.messageReadCount - page * 30;
        }

        //type.Message로 변환
        final List<types.Message> messageList =
            chatMessages.data!.messages.map(toTextMessage).toList();

        //각 메세지에 readMember넣어줌
        for (var i = 0; i < messageList.length; i++) {
          List<int> readMembers = [];
          for (var entry in readCountMap.entries) {
            if (i >= entry.value) {
              readMembers.add(entry.key);
            }
          }
          messageList[i] = messageList[i].copyWith(metadata: {
            ...messageList[i].metadata!,
            'readMember': readMembers,
          });
        }

        //각 메세지마다 랜덤넘버 부여
        for (int i = 0; i < messageList.length; i++) {
          Random random = Random();
          messageList[i] = messageList[i].copyWith(
            id: '${messageList[i].id}-${random.nextInt(1000)}',
          );
        }

        //메세지가 없거나 30개 이하면 마지막페이지
        if (messageList.length < 30 || messageList.isEmpty) {
          isLast = true;
        }
        if (messageList.isNotEmpty) {
          state = [...state, ...messageList];
        }
        page++;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendMessage(String message) async {
    try {
      final request = SendMessageRequest(
          message: message, chatRoomId: chatRoomId, messageType: 'TEXT');
      await repository.sendMessage(request);
      addMessage(message);
    } catch (e) {
      print(e.toString());
    }
  }

  void addMessage(String message) {
    var now = DateTime.now().millisecondsSinceEpoch;
    var uniqueId = Uuid().v4();
    var random = Random().nextInt(100000);
    final userState = ref.read(userViewModelProvider);
    if (userState is LoadedUserState) {
      final textMessage = types.TextMessage(
        author: types.User(id: userState.user.userId.toString()),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: '$now - $uniqueId - $random',
        text: message,
        metadata: const {'readMember': []},
      );
      ref.read(chatDetailProvider.notifier).updateMessageReadCount(chatRoomId);
      state = [textMessage, ...state];
    }
  }

  void setRoomId(int id) {
    chatRoomId = id;
  }

  void listener() async {
    channel.stream.listen((message) async {
      print(message);
      final Map<String, dynamic> decodedMessage = json.decode(message);
      final channel = decodedMessage['channel'] as String;
      final userState = ref.read(userViewModelProvider);
      print(chatRoomId);
      if (userState is LoadedUserState) {
        if (channel == 'CHAT_READ') {
          final chatReadResponse =
              ChatReadResponse.fromJson(decodedMessage['data']);
          print('룸아이디: ${chatReadResponse.chatRoomId}');
          print('보낸사람아이디: ${chatReadResponse.senderId}');
          print('메세지 리드카운트: ${chatReadResponse.messageReadCount}');
          if (chatRoomId == chatReadResponse.chatRoomId) {
            updateReadStatus(
                chatReadResponse.chatRoomId, chatReadResponse.senderId);
          }
        }
        if (channel == 'CHAT_MATCH') {
          final chatMatchResponse =
              ChatMatchResponse.fromJson(decodedMessage['data']);
          print('룸아이디: ${chatMatchResponse.chatRoomId}');
          ref.read(homeRandomChatViewModelProvider.notifier).getRandomChatInfo();
          ref.read(chatDetailProvider.notifier)
              .getMessageInfo(chatMatchResponse.chatRoomId)
              .then((_) {
            if (GlobalVariable.naviagatorState.currentContext != null) {
              GlobalVariable.naviagatorState.currentContext!
                  .go('/chatDetail2', extra: chatMatchResponse.chatRoomId);
            }
          });
        }
        if (channel == 'CHAT_MESSAGE') {
          final chatMessage = ChatMessageResponse<MessageData>.fromJson(
            decodedMessage,
            (json) => MessageData.fromJson(json as Map<String, dynamic>),
          );
          print('이거이거좀 되라${chatMessage.data.chatId}');
          print('이거좀되라$chatMessage');
          ref.read(chatListProvider.notifier).updateChatListMessage(
                chatMessage.data.chatRoomId,
                chatMessage.data.message,
              );
          if (chatRoomId == chatMessage.data.chatRoomId) {
            totalCount = chatMessage.data.messageCount;
            if (userState.user.userId != chatMessage.data.senderId) {
              ref
                  .read(chatDetailProvider.notifier)
                  .updateMessageReadCount(chatMessage.data.chatRoomId);
              getMessageList();
              var random = Random().nextInt(100000);
              final textMessage = types.TextMessage(
                author: types.User(id: chatMessage.data.senderId.toString()),
                createdAt: DateTime.now().millisecondsSinceEpoch,
                id: '${chatMessage.data.chatId} - $random',
                text: chatMessage.data.message,
              );
              state = [textMessage, ...state];
            }
          }
        }
      }
    });
  }

  void updateReadStatus(int chatRoomId, int userId) {
    state = state.map((message) {
      if (message.metadata != null &&
          message.metadata!['readMember'] != null &&
          !message.metadata!['readMember'].contains(userId)) {
        List<int> readMember = List<int>.from(message.metadata!['readMember']);
        readMember.add(userId);
        return message.copyWith(metadata: {
          ...message.metadata!,
          'readMember': readMember,
        });
      }
      return message;
    }).toList();
  }

  types.TextMessage toTextMessage(Message message) {
    return types.TextMessage(
      author: types.User(id: message.userId.toString()),
      createdAt: message.registerDate.millisecondsSinceEpoch,
      id: message.chatId,
      text: message.message,
      metadata: const {'readMember': []},
    );
  }
}

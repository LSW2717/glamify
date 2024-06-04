
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_message_view_model.g.dart';

@Riverpod(keepAlive: true)
class MessageViewModel extends _$MessageViewModel {
  @override
  List<Message> build(User user) {
    return [
      // TextMessage(
      //   author: User(id: '1'),
      //   createdAt:
      //   DateTime.now().subtract(Duration(minutes: 5)).millisecondsSinceEpoch,
      //   id: '1',
      //   text: '안녕하세요, 오늘 기분이 어때요?',
      // ),
      // TextMessage(
      //   author: User(id: '2'),
      //   createdAt:
      //   DateTime.now().subtract(Duration(minutes: 4)).millisecondsSinceEpoch,
      //   id: '2',
      //   text: '안녕하세요! 기분이 좋습니다. 당신은요?',
      // ),
      // TextMessage(
      //   author: User(id: '1'),
      //   createdAt:
      //   DateTime.now().subtract(Duration(minutes: 3)).millisecondsSinceEpoch,
      //   id: '3',
      //   text: '저도 좋습니다. 오늘 날씨가 참 좋네요.',
      // ),
      // TextMessage(
      //   author: User(id: '2'),
      //   createdAt:
      //   DateTime.now().subtract(Duration(minutes: 2)).millisecondsSinceEpoch,
      //   id: '4',
      //   text: '네, 산책하기 딱 좋은 날씨입니다.',
      // ),
    ];
  }

  void handleSendPressed(PartialText message) {
    final textMessage = TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: user.id,
      text: message.text,
    );
    _addMessage(textMessage);
  }

  void sendPressed(String text) {
    if (text.isNotEmpty) {
      final message = PartialText(text: text);
      final textMessage = TextMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: user.id,
        text: message.text,
      );

      _addMessage(textMessage);
    }
  }

  void _addMessage(Message message) {
    state = [message, ...state];
  }


// void _loadMessages() async {
  //   final response = await rootBundle.loadString('assets/messages.json');
  //   final messages = (jsonDecode(response) as List)
  //       .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
  //       .toList();
  //
  //   setState(() {
  //     _messages = messages;
  //   });
  // }



}

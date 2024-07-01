import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_room_id_view_model.g.dart';

@Riverpod(keepAlive: true)
class ChatRoomIdViewModel extends _$ChatRoomIdViewModel {
  @override
  int build() {
    return 0;
  }

  void setRoomId(int id){
    state = id;
  }
}

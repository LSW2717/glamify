import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/common/model/empty_dto_model.dart';

import '../model/chat_room_response_model.dart';
import '../repository/chat_repository.dart';

final chatInviteListProvider =
    StateNotifierProvider<ChatInviteListViewModel, InviteState>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatInviteListViewModel(repository);
});

class ChatInviteListViewModel extends StateNotifier<InviteState> {
  final ChatRepository repository;

  ChatInviteListViewModel(
    this.repository,
  ) : super(const LoadingInviteState());

  Future<void> getChatInviteList() async {
    state = const LoadingInviteState();
    final request = EmptyDto();
    final response = await repository.getChatInvitation(request);
    if (response.code == 200) {
      state = LoadedInviteState(response.data!);
    } else {
      state = ErrorInviteState(response.message);
      print(response.message);
    }
  }
}

abstract class InviteState {
  const InviteState();
}

class LoadingInviteState extends InviteState {
  const LoadingInviteState();
}

class LoadedInviteState extends InviteState {
  final ChatInvitationsResponse response;

  const LoadedInviteState(
    this.response,
  );
}

class ErrorInviteState extends InviteState {
  final String message;

  const ErrorInviteState(
    this.message,
  );
}

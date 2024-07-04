import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/common/view_model/tab_index_view_model.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';

import '../model/user_model.dart';

final authProvider = ChangeNotifierProvider<AuthViewModel>((ref) {
  return AuthViewModel(ref: ref);
});

class AuthViewModel extends ChangeNotifier {
  final Ref ref;

  AuthViewModel({
    required this.ref,
  }) {
    // ref.listen<UserState?>(userViewModelProvider, (previous, next) {
    //   if (previous != next) {
    //     notifyListeners();
    //   }
    // });
  }
  void logout() {
    ref.read(userViewModelProvider.notifier).logout();
  }

  String? redirectLogic(BuildContext context, GoRouterState state) {
    final UserState? user = ref.read(userViewModelProvider);
    final isSettingIn = state.uri.path == '/setting';
    // if (user is! UserModel && isSettingIn == true) {
    //   return '/';
    // }
    return null;
  }
}

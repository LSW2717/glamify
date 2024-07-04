import 'package:glamify/mypage/model/agreement_request_model.dart';
import 'package:glamify/user/model/user_model.dart';
import 'package:glamify/user/repository/user_repository.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'noti_setting_view_model.g.dart';

@Riverpod(keepAlive: true)
class NotiSettingViewModel extends _$NotiSettingViewModel {
  UserRepository get repository => ref.watch(userRepositoryProvider);

  @override
  bool build() {
    final userState = ref.watch(userViewModelProvider);
    if (userState is LoadedUserState) {
      final bool currentState =
          userState.user.pushNotificationAgreement == 'Y' ? true : false;
      return currentState;
    }
    return false;
  }

  Future<void> setAlarmState() async {
    state = !state;
    if (state == true) {
      await repository
          .updateNotificationAgreement(AgreementRequest(agreement: 'Y'));
    } else {
      await repository
          .updateNotificationAgreement(AgreementRequest(agreement: 'N'));
    }
  }
}

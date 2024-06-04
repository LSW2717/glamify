import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:glamify_mobile/common/model/response_dto.dart';
import 'package:glamify_mobile/common/model/token_response_model.dart';
import 'package:glamify_mobile/common/repository/test_repository.dart';
import 'package:glamify_mobile/user/model/fcm_token_request_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../chat/repository/chat_repository.dart';
import '../../common/data_source/data.dart';
import '../../common/model/dummy.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../model/user_model.dart';
import '../repository/user_repository.dart';

part 'user_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserViewModel extends _$UserViewModel {

  UserRepository get userRepository => ref.watch(userRepositoryProvider);
  TestRepository get testRepository => ref.watch(testRepositoryProvider);
  ChatRepository get chatRepository => ref.watch(chatRepositoryProvider);
  FlutterSecureStorage get storage => ref.watch(secureStorageProvider);

  @override
  UserState? build() {
    getMe();
    return LoadingUserState();
  }
  Future<void> login() async {
    state = LoadingUserState();
    try {
      final url = Uri.parse('http://$ip/v1/auth/kakao_login');
      final result = await FlutterWebAuth2.authenticate(
        url: url.toString(),
        callbackUrlScheme: APP_REDIRECT_URI,
      );

      final fcmToken = await storage.read(key: FCM_TOKEN_KEY);

      if (fcmToken != null) {
        await userRepository
            .updateFcmToken(FcmTokenRequest(pushNotificationToken: fcmToken));
      }

      final accessToken = Uri.parse(result).queryParameters['access_token'];
      final refreshToken = Uri.parse(result).queryParameters['refresh_token'];

      print(accessToken);
      print(refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
      await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);

      final user = await userRepository.getUserInfo();

      state = user.data;
    } catch (e) {
      state = ErrorUserState(message: e.toString());
    }
  }

  Future<void> healthCheck() async {
    Dummy dummy = Dummy(dummy: 5);
    final check = await testRepository.postHealthCheck(dummy);
    print(check.code);
    print(check.data);
    print(check.message);
  }

  Future<void> logout() async {
    state = null;
    await Future.wait(
      [
        storage.delete(key: REFRESH_TOKEN_KEY),
        storage.delete(key: ACCESS_TOKEN_KEY),
      ],
    );
  }

  Future<ResponseDto<TokenResponse>> reissue() async {
    final tokens = await userRepository.reissue();
    return tokens;
  }

  Future<void> chatCheck() async {
    final response = await chatRepository.requestChatWaiting();
    print(response.message);
    print(response.data);
    print(response.code);
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }
    final user = await userRepository.getUserInfo();

    await storage.write(
        key: REFRESH_TOKEN_KEY, value: user.data?.user.refreshToken);
    state = user.data;
  }

}
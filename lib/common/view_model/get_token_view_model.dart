import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:glamify/common/secure_storage/secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data_source/data.dart';

part 'get_token_view_model.g.dart';

@Riverpod(keepAlive: true)
@riverpod
class GetTokenViewModel extends _$GetTokenViewModel {

  FlutterSecureStorage get storage => ref.watch(secureStorageProvider);

  @override
  String build() {
    getToken();
    return '';
  }

  Future<void> getToken() async {
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    if (token == null){
      state = '';
    }else{
     state = token;
    }
  }
}
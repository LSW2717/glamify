
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_token_view_model.g.dart';


@riverpod
class RefreshTokenViewModel extends _$RefreshTokenViewModel {
  @override
  String build() {
    return '';
  }

  void setToken(String value){
    state = value;
  }
}
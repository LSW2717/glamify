import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../user/view_model/auth_view_model.dart';
import '../data_source/data.dart';
import '../secure_storage/secure_storage.dart';

part 'dio.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);
  dio.interceptors.add(
    CustomInterceptor(
      storage: storage,
      ref: ref,
    ),
  );
  dio.options = BaseOptions(
    sendTimeout: const Duration(seconds: 5),
  );
  return dio;
}

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({
    required this.storage,
    required this.ref,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      options.headers.addAll({
        'Authorization': '$token',
      });
    }
    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');
      final token = await storage.read(key: REFRESH_TOKEN_KEY);
      options.headers.addAll({
        'Authorization': '$token',
      });
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    if (refreshToken == null) {
      return handler.reject(err);
    }
    final isPathRefresh = err.requestOptions.path == '/api/auth/reissue';

    if (!isPathRefresh) {
      final dio = Dio();
      try {
        final resp = await ref.read(userViewModelProvider.notifier).reissue();

        final accessToken = resp.data?.accessToken;
        final refreshToken = resp.data?.refreshToken;

        final options = err.requestOptions;

        options.headers.addAll({
          'Authorization': '$accessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
        // 요청 재전송
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } on DioException catch (error) {
        ref.read(authProvider.notifier).logout();
        return handler.reject(error);
      } catch (error) {
        print("An unexpected error occurred: $error");
        return handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: "An unexpected error occurred",
        ));
      }
    }

    return handler.reject(err);
  }
}

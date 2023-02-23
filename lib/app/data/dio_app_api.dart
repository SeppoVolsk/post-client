import 'package:chat_client/app/domain/app_api.dart';
import 'package:chat_client/app/domain/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'auth_interceptor.dart';

@Singleton(as: AppApi)
class DioAppApi implements AppApi {
  late final Dio dio;
  late final Dio dioTokens;

  DioAppApi(AppConfig appConfig) {
    final options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      //connectTimeout: const Duration(seconds: 5),
    );
    dio = Dio(options);
    dioTokens = Dio(options);
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger());
      dioTokens.interceptors.add(PrettyDioLogger());
    }
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<Response> getProfile() {
    try {
      return dio.get("/auth/user");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> passwordUpdate(
      {required String oldPassword, required String newPassword}) {
    try {
      return dio.put("/auth/user", queryParameters: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> refreshToken({String? refreshToken}) {
    try {
      return dioTokens.post("/auth/token/$refreshToken");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> signIn(
      {required String password, required String username}) {
    try {
      return dio.post("/auth/token",
          data: {"username": username, "password": password});
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> signUp(
      {required String password,
      required String username,
      required String email}) {
    try {
      return dio.put("/auth/token", data: {
        "username": username,
        "password": password,
        "email": email,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> userUpdate({String? username, String? email}) {
    try {
      return dio.post("/auth/user", data: {
        "username": username,
        "email": email,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future request(String path) {
    try {
      return dio.request(path);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future fetch(RequestOptions requestOptions) {
    return dioTokens.fetch(requestOptions);
  }

  @override
  Future fetchPosts(int fetchLimit, int offset) {
    return dio.get("/data/posts",
        queryParameters: {"fetchLimit": fetchLimit, "offset": offset});
  }

  @override
  Future createPost(Map args) {
    return dio.post("/data/posts", data: {
      "name": args["name"],
      "content": args["content"],
    });
  }

  @override
  Future fetchPost(String id) {
    return dio.get("/data/posts/$id");
  }

  @override
  Future deletePost(String id) {
    return dio.delete("/data/posts/$id");
  }
}

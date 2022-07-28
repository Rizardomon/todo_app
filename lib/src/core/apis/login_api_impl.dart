import 'dart:developer';

import 'package:dio/dio.dart';

import 'login_api.dart';

class LoginApiImpl implements LoginApi {
  final Dio _clientHttp;

  LoginApiImpl(this._clientHttp);

  @override
  Future<bool> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _clientHttp.post('/user', data: {
        "name": name,
        "email": email,
        "password": password,
      });

      return response.statusCode == 201 ? true : false;
    } catch (e) {
      log('[ERROR/API | ${DateTime.now()}] -> $e');
      rethrow;
    }
  }

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _clientHttp.post('/login', data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> validMap = response.data;

        return validMap['token'];
      } else if (response.statusCode == 401) {
        return 'Não autorizado';
      } else {
        return 'Erro interno do servidor';
      }
    } catch (e) {
      log('[ERROR/API | ${DateTime.now()}] -> $e');
      rethrow;
    }
  }
}

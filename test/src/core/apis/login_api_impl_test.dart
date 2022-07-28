import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:todo_app_api/src/core/apis/login_api_impl.dart';

void main() async {
  late Dio dio;
  late DioAdapter dioAdapter;
  late LoginApiImpl loginApi;

  var baseUrl = faker.internet.httpUrl();

  const signUpRoute = '/user';
  const loginRoute = '/login';

  String name = faker.person.firstName();
  String email = faker.internet.email();
  String password = faker.internet.password();

  String accessToken = faker.jwt.valid();

  var userCredentials = <String, dynamic>{
    'name': name,
    'email': email,
    'password': password,
  };

  var loginCredentials = <String, dynamic>{
    'email': email,
    'password': password,
  };

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    dioAdapter = DioAdapter(
      dio: dio,
      matcher: const FullHttpRequestMatcher(),
    );
    loginApi = LoginApiImpl(dio);
  });

  test('Should handle create user', () async {
    dioAdapter
      ..onPost(
        signUpRoute,
        (server) => server.throws(
          401,
          DioError(
            requestOptions: RequestOptions(
              path: signUpRoute,
            ),
          ),
        ),
      )
      ..onPost(
        signUpRoute,
        (server) => server.reply(201, null),
        data: userCredentials,
      );

    expect(
      () async => await loginApi.createUser(
        name: name,
        email: '',
        password: password,
      ),
      throwsA(isA<DioError>()),
    );

    expect(
      () async => await loginApi.createUser(
        name: name,
        email: email,
        password: '',
      ),
      throwsA(isA<DioError>()),
    );

    final response = await loginApi.createUser(
      name: name,
      email: email,
      password: password,
    );

    expect(response, true);
  });

  test('Should handle login', () async {
    dioAdapter
      ..onPost(
        loginRoute,
        (server) => server.throws(
          401,
          DioError(
            requestOptions: RequestOptions(
              path: loginRoute,
            ),
          ),
        ),
      )
      ..onPost(
        loginRoute,
        (server) => server.reply(200, {'token': accessToken}),
        data: loginCredentials,
      );

    expect(
      () async => await loginApi.login(
        email: '',
        password: password,
      ),
      throwsA(isA<DioError>()),
    );

    expect(
      () async => await loginApi.login(
        email: email,
        password: '',
      ),
      throwsA(isA<DioError>()),
    );

    final response = await loginApi.login(
      email: email,
      password: password,
    );

    expect(response, accessToken);
  });
}

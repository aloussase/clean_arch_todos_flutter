import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../../domain/repository/auth_repository.dart';

final class AuthRepositoryImpl implements AuthRepository {
  final Client _client;
  final _controller = StreamController<AuthState>();

  // TODO: Move this to a configuration object.
  static const API_BASE = "http://192.168.1.19:5129";

  AuthRepositoryImpl({required Client httpClient}) : _client = httpClient;

  @override
  Future<String?> login(String username, String password) async {
    final response = await _client.post(
      Uri.parse("$API_BASE/login"),
      body: jsonEncode(
        {
          "username": username,
          "password": password,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );

    final jsonBody = jsonDecode(response.body);
    final accessToken = jsonBody["token"];

    _controller.add(
      Authenticated(
        accessToken: accessToken,
        username: username,
      ),
    );

    return accessToken;
  }

  @override
  Future<void> register(String username, String password) async {
    await _client.post(
      Uri.parse("$API_BASE/register"),
      body: jsonEncode(
        {
          "username": username,
          "password": password,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
  }

  @override
  Stream<AuthState> get authState async* {
    yield Unauthenticated();
    yield* _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
  }
}

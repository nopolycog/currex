import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:currex/logic/repos/auth/auth_repo.dart';
import 'package:currex/ui/di/di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

enum AuthStatus { auth, unauth, error }

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthStatus build() => AuthStatus.unauth;

  Future<void> login(String data) async {
    final String? localData = await getIt<AuthRepo>().get();

    if (sha1.convert(utf8.encode(data)).toString() == localData) {
      state = AuthStatus.auth;
    } else {
      state = AuthStatus.error;
    }
  }

  void logout() => state = AuthStatus.unauth;
}

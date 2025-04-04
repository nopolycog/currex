import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:currex/data/sources/local/local_secured_source.dart';
import 'package:currex/logic/repos/auth/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AppLocalSecuredSource source;

  AuthRepoImpl(this.source);

  @override
  Future<void> put(String data) async => await source.put('auth', sha1.convert(utf8.encode(data)).toString());

  @override
  Future<String?> get() async => await source.get('auth');
}

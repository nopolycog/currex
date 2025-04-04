import 'package:dio/dio.dart';

class AppRemoteSource {
  AppRemoteSource(this.api);

  final Dio api;

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      api.get(path, queryParameters: queryParameters);
}

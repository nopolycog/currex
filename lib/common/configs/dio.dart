import 'package:currex/common/configs/keys.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://rest.coincap.io/v3/',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {'Content-Type': 'application/json', 'accept': 'application/json', 'Authorization': 'Bearer $apiKey'},
  ),
);

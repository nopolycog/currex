import 'package:currex/logic/entities/rate_model.dart';
import 'package:dio/dio.dart' show DioException;

abstract class RatesRepo {
  Future<(List<RateModel>?, DioException?)> getRates(int limit, int offset);
}

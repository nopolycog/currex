import 'package:currex/data/sources/remote/remote_source.dart';
import 'package:currex/logic/entities/rate_model.dart';
import 'package:currex/logic/repos/rates/rates_repo.dart';
import 'package:dio/dio.dart' show DioException;

class RatesRepoImpl extends RatesRepo {
  final AppRemoteSource source;

  RatesRepoImpl(this.source);

  @override
  Future<(List<RateModel>?, DioException?)> getRates() async {
    try {
      final response = await source.get('rates');
      return ((response.data['data'] as List).map((e) => RateModel.fromJson(e as Map<String, dynamic>)).toList(), null);
    } on DioException catch (error) {
      return (null, error);
    }
  }
}

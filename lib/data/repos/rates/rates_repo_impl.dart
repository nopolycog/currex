import 'package:currex/data/sources/remote/remote_source.dart';
import 'package:currex/logic/entities/rate_model.dart';
import 'package:currex/logic/repos/rates/rates_repo.dart';

class RatesRepoImpl extends RatesRepo {
  final AppRemoteSource source;

  RatesRepoImpl(this.source);

  @override
  Future<List<RateModel>?> getRates(int limit, int offset) async {
    final response = await source.get('assets?limit=$limit&offset=$offset');
    if (response.statusCode == 200) {
      return (response.data['data'] as List).map((e) => RateModel.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load rates');
    }
  }
}

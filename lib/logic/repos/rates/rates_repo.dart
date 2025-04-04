import 'package:currex/logic/entities/rate_model.dart';

abstract class RatesRepo {
  Future<List<RateModel>?> getRates(int limit, int offset);
}

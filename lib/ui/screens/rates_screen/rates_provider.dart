import 'package:currex/logic/repos/rates/rates_repo.dart';
import 'package:currex/ui/di/di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rates_provider.g.dart';

enum RatesStatus { loading, done, error }

@Riverpod(keepAlive: true)
class Rates extends _$Rates {
  @override
  RatesStatus build() {
    getRates();
    return RatesStatus.loading;
  }

  Future<void> getRates() async {
    await getIt<RatesRepo>().getRates(10, 0);
  }

  void update() => state = RatesStatus.done;
}

import 'dart:async' show Timer;
import 'package:currex/logic/repos/rates/rates_repo.dart';
import 'package:currex/ui/di/di.dart';
import 'package:currex/ui/screens/convert_screen/convert_provider.dart';
import 'package:currex/ui/screens/rates_screen/rates_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rates_provider.g.dart';

@Riverpod(keepAlive: true)
class Rates extends _$Rates {
  Timer? _timer;

  @override
  RatesState build() {
    _getRates();
    // _startTimer();
    return RatesState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (state.isUpdating) return;
      await refresh();
      _restartTimer();
    });
  }

  void _restartTimer() {
    _timer?.cancel();
    _timer = null;
    _startTimer();
  }

  Future<void> _getRates() async {
    final result = await getIt<RatesRepo>().getRates();
    state = state.copyWith(
      status: RatesStatus.done,
      ratesCrypto: (result.$1 ?? []).where((value) => value.type == 'crypto').toList(),
      ratesFiat: (result.$1 ?? []).where((value) => value.type == 'fiat').toList(),
      error: result.$2,
    );
    ref.read(convertProvider.notifier).get();
  }

  Future<void> refresh() async {
    state = state.copyWith(isUpdating: true);
    final result = await getIt<RatesRepo>().getRates();
    state = state.copyWith(
      status: RatesStatus.done,
      ratesCrypto: (result.$1 ?? []).where((value) => value.type == 'crypto').toList(),
      ratesFiat: (result.$1 ?? []).where((value) => value.type == 'fiat').toList(),
      error: result.$2,
      isUpdating: false,
    );
    ref.read(convertProvider.notifier).get();
  }
}

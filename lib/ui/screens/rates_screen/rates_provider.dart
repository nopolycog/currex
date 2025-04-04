import 'dart:async' show Timer;
import 'package:currex/logic/entities/rate_model.dart';
import 'package:currex/logic/repos/rates/rates_repo.dart';
import 'package:currex/ui/di/di.dart';
import 'package:currex/ui/screens/rates_screen/rates_state.dart';
import 'package:dio/dio.dart' show DioException;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rates_provider.g.dart';

@Riverpod(keepAlive: true)
class Rates extends _$Rates {
  static const _itemsPerPage = 50;
  Timer? _timer;

  @override
  RatesState build() {
    _loadInitialRates();
    _startTimer();
    return RatesState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (state.isUpdating) return;
      await update();
      restartTimer();
    });
  }

  void restartTimer() {
    _timer?.cancel();
    _timer = null;
    _startTimer();
  }

  Future<void> _loadInitialRates() async {
    final result = await getIt<RatesRepo>().getRates(_itemsPerPage, 0);
    state = state.copyWith(
      status: RatesStatus.done,
      rates: result.$1 ?? [],
      error: result.$2,
      currentPage: 1,
      hasMore: (result.$1?.length ?? 0) >= _itemsPerPage,
    );
  }

  Future<void> loadMoreRates() async {
    if (state.isLoading || !state.hasMore) return;

    final offset = state.currentPage * _itemsPerPage;
    final result = await getIt<RatesRepo>().getRates(_itemsPerPage, offset);

    state = state.copyWith(
      rates: (state.rates ?? []) + (result.$1 ?? []),
      error: result.$2,
      currentPage: state.currentPage + 1,
      hasMore: (result.$1?.length ?? 0) >= _itemsPerPage,
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(status: RatesStatus.loading, currentPage: 1);
    final result = await getIt<RatesRepo>().getRates(_itemsPerPage, 0);
    state = state.copyWith(
      status: RatesStatus.done,
      rates: result.$1,
      error: result.$2,
      hasMore: (result.$1?.length ?? 0) >= _itemsPerPage,
    );
  }

  Future<void> update() async {
    List<RateModel>? rates = [];
    DioException? error;

    state = state.copyWith(isUpdating: true);

    for (int i = 0; i < state.currentPage + 1; i++) {
      final offset = i * _itemsPerPage;
      final result = await getIt<RatesRepo>().getRates(_itemsPerPage, offset);
      rates = (rates ?? []) + (result.$1 ?? []);
    }

    state = state.copyWith(
      rates: rates,
      error: error,
      isUpdating: false,
      hasMore: (rates?.length ?? 0) >= _itemsPerPage,
    );
  }
}

import 'package:currex/logic/entities/rate_model.dart';
import 'package:dio/dio.dart' show DioException;

enum RatesStatus { loading, done }

class RatesState {
  final RatesStatus status;
  final List<RateModel>? ratesCrypto;
  final List<RateModel>? ratesFiat;
  final DioException? error;
  final bool isUpdating;

  RatesState({
    this.status = RatesStatus.loading,
    this.ratesCrypto = const [],
    this.ratesFiat = const [],
    this.error,
    this.isUpdating = false,
  });

  RatesState copyWith({
    RatesStatus? status,
    List<RateModel>? ratesCrypto,
    List<RateModel>? ratesFiat,
    DioException? error,
    bool? isUpdating,
  }) {
    return RatesState(
      status: status ?? this.status,
      ratesCrypto: ratesCrypto ?? this.ratesCrypto,
      ratesFiat: ratesFiat ?? this.ratesFiat,
      error: error ?? this.error,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }

  bool get isLoading => status == RatesStatus.loading;
  bool get hasError => error != null;
}

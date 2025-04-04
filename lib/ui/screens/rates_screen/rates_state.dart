import 'package:currex/logic/entities/rate_model.dart';
import 'package:dio/dio.dart' show DioException;

enum RatesStatus { loading, done }

class RatesState {
  final RatesStatus status;
  final List<RateModel>? rates;
  final DioException? error;
  final int currentPage;
  final bool isUpdating;
  final bool hasMore;

  RatesState({
    this.status = RatesStatus.loading,
    this.rates = const [],
    this.error,
    this.currentPage = 0,
    this.isUpdating = false,
    this.hasMore = false,
  });

  RatesState copyWith({
    RatesStatus? status,
    List<RateModel>? rates,
    DioException? error,
    int? currentPage,
    bool? isUpdating,
    bool? hasMore,
  }) {
    return RatesState(
      status: status ?? this.status,
      rates: rates ?? this.rates,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      isUpdating: isUpdating ?? this.isUpdating,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  bool get isLoading => status == RatesStatus.loading;
  bool get hasError => error != null;
}

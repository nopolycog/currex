import 'package:currex/logic/entities/rate_model.dart';

class ConvertState {
  final RateModel? from;
  final RateModel? to;
  final double amount;

  ConvertState({this.from, this.to, this.amount = 0.0});

  ConvertState copyWith({RateModel? from, RateModel? to, double? amount}) {
    return ConvertState(from: from ?? this.from, to: to ?? this.to, amount: amount ?? this.amount);
  }
}

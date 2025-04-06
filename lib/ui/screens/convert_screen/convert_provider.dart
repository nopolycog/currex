import 'package:currex/ui/screens/convert_screen/convert_state.dart';
import 'package:currex/ui/screens/rates_screen/rates_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'convert_provider.g.dart';

@Riverpod(keepAlive: true)
class Convert extends _$Convert {
  @override
  ConvertState build() {
    return ConvertState();
  }

  Future<void> get() async {
    state = state.copyWith(
      from: ref.read(ratesProvider).ratesCrypto?.first,
      to: ref.read(ratesProvider).ratesFiat?.first,
    );
  }

  Future<void> update() async {
    state = state.copyWith(
      from: ref.read(ratesProvider).ratesCrypto?.firstWhere((value) => value == state.from),
      to: ref.read(ratesProvider).ratesFiat?.firstWhere((value) => value == state.to),
    );
  }

  void onSelectedFrom(int index) {
    state = state.copyWith(from: ref.read(ratesProvider).ratesCrypto?[index]);
  }

  void onSelectedTo(int index) {
    state = state.copyWith(to: ref.read(ratesProvider).ratesFiat?[index]);
  }

  void onChangedAmount(String value) {
    state = state.copyWith(amount: double.tryParse(value) ?? 0);
  }
}

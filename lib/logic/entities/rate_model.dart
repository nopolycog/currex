import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_model.freezed.dart';
part 'rate_model.g.dart';

@freezed
sealed class RateModel with _$RateModel {
  @JsonSerializable(explicitToJson: true)
  const factory RateModel({
    required String id,
    required String symbol,
    required String name,
    required String priceUsd,
  }) = _RateModel;

  factory RateModel.fromJson(Map<String, Object?> json) => _$RateModelFromJson(json);
}

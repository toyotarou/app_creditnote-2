import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_response_state.freezed.dart';

@freezed
class CreditResponseState with _$CreditResponseState {
  const factory CreditResponseState({
    @Default(0) int itemPos,
    @Default([]) List<String> creditDates,
    @Default([]) List<String> creditNames,
    @Default([]) List<int> creditPrices,
  }) = _CreditResponseState;
}

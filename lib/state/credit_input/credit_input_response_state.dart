import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_input_response_state.freezed.dart';

@freezed
class CreditInputResponseState with _$CreditInputResponseState {
  const factory CreditInputResponseState({
    @Default(0) int itemPos,
    @Default([]) List<String> creditDates,
    @Default([]) List<String> creditNames,
    @Default([]) List<int> creditPrices,
  }) = _CreditInputResponseState;
}

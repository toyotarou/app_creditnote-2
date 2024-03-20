import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_detail_input_response_state.freezed.dart';

@freezed
class CreditDetailInputResponseState with _$CreditDetailInputResponseState {
  const factory CreditDetailInputResponseState({
    @Default(0) int itemPos,
    //

    @Default(0) int diff,
    @Default('') String baseDiff,

    ///

    @Default([]) List<String> creditDetailInputDates,
    @Default([]) List<String> creditDetailInputItems,
    @Default([]) List<int> creditDetailInputPrices,
    @Default([]) List<String> creditDetailInputDescriptions,
  }) = _CreditDetailInputResponseState;
}

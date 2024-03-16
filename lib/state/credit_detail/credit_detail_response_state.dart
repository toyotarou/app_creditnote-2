import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_detail_response_state.freezed.dart';

@freezed
class CreditDetailResponseState with _$CreditDetailResponseState {
  const factory CreditDetailResponseState({
    @Default(0) int itemPos,
    //

    @Default(0) int diff,
    @Default('') String baseDiff,

    ///

    @Default([]) List<String> creditDetailDates,
    @Default([]) List<String> creditDetailItems,
    @Default([]) List<int> creditDetailPrices,
    @Default([]) List<String> creditDetailDescriptions,
  }) = _CreditDetailResponseState;
}

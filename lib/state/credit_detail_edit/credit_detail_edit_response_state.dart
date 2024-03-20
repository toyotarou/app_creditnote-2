import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_detail_edit_response_state.freezed.dart';

@freezed
class CreditDetailEditResponseState with _$CreditDetailEditResponseState {
  const factory CreditDetailEditResponseState({
    @Default('') String creditDetailEditDate,
    @Default('') String creditDetailEditItem,
    @Default(0) int creditDetailEditPrice,
    @Default('') String creditDetailEditDescription,
  }) = _CreditDetailEditResponseState;
}

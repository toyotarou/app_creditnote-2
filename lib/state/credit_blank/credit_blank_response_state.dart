import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/credit_blank_input_value.dart';

part 'credit_blank_response_state.freezed.dart';

@freezed
class CreditBlankResponseState with _$CreditBlankResponseState {
  const factory CreditBlankResponseState({
    @Default([]) List<CreditBlankInputValue> creditBlankInputValueList,
  }) = _CreditBlankResponseState;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_start_yearmonth_response_state.freezed.dart';

@freezed
class ConfigStartYearmonthResponseState with _$ConfigStartYearmonthResponseState {
  const factory ConfigStartYearmonthResponseState({
    @Default(<int>[]) List<int> startYears,
    @Default(<int>[]) List<int> startMonths,
    @Default(-1) int selectedStartYear,
    @Default(-1) int selectedStartMonth,
  }) = _ConfigStartYearmonthResponseState;
}

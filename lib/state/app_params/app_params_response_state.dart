import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_params_response_state.freezed.dart';

@freezed
class AppParamsResponseState with _$AppParamsResponseState {
  const factory AppParamsResponseState({
    @Default(false) bool inputButtonClicked,
    @Default(<int, String>{}) Map<int, String> creditBlankSettingMap,
    @Default('') String homeListSelectedYearmonth,
  }) = _AppParamsResponseState;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_download_response_state.freezed.dart';

@freezed
class DataDownloadResponseState with _$DataDownloadResponseState {
  const factory DataDownloadResponseState({
    @Default('') String startYearMonth,
    @Default('') String endYearMonth,
  }) = _DataDownloadResponseState;
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../enums/data_download_data_type.dart';

part 'data_download_response_state.freezed.dart';

@freezed
class DataDownloadResponseState with _$DataDownloadResponseState {
  const factory DataDownloadResponseState({
    @Default('') String startYearMonth,
    @Default('') String endYearMonth,
    DateDownloadDataType? dataType,
  }) = _DataDownloadResponseState;
}

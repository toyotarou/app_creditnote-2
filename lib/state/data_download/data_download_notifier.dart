import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'data_download_response_state.dart';

final dataDownloadProvider = StateNotifierProvider.autoDispose<DataDownloadNotifier, DataDownloadResponseState>((ref) {
  return DataDownloadNotifier(const DataDownloadResponseState());
});

class DataDownloadNotifier extends StateNotifier<DataDownloadResponseState> {
  DataDownloadNotifier(super.state);

  ///
  Future<void> setStartYearMonth({required String yearmonth}) async => state = state.copyWith(startYearMonth: yearmonth);

  ///
  Future<void> setEndYearMonth({required String yearmonth}) async => state = state.copyWith(endYearMonth: yearmonth);
}

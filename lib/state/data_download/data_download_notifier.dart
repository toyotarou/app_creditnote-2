import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../enums/data_download_data_type.dart';
import 'data_download_response_state.dart';

final AutoDisposeStateNotifierProvider<DataDownloadNotifier, DataDownloadResponseState> dataDownloadProvider = StateNotifierProvider.autoDispose<DataDownloadNotifier, DataDownloadResponseState>((AutoDisposeStateNotifierProviderRef<DataDownloadNotifier, DataDownloadResponseState> ref) {
  return DataDownloadNotifier(const DataDownloadResponseState());
});

class DataDownloadNotifier extends StateNotifier<DataDownloadResponseState> {
  DataDownloadNotifier(super.state);

  ///
  Future<void> setStartYearMonth({required String yearmonth}) async =>
      state = state.copyWith(startYearMonth: yearmonth);

  ///
  Future<void> setEndYearMonth({required String yearmonth}) async => state = state.copyWith(endYearMonth: yearmonth);

  ///
  Future<void> setDataType({required DateDownloadDataType dataType}) async =>
      state = state.copyWith(dataType: dataType);
}

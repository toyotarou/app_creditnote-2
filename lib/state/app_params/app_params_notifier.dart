import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app_params_response_state.dart';

final AutoDisposeStateNotifierProvider<AppParamNotifier, AppParamsResponseState> appParamProvider = StateNotifierProvider.autoDispose<AppParamNotifier, AppParamsResponseState>((AutoDisposeStateNotifierProviderRef<AppParamNotifier, AppParamsResponseState> ref) {
  return AppParamNotifier(const AppParamsResponseState());
});

class AppParamNotifier extends StateNotifier<AppParamsResponseState> {
  AppParamNotifier(super.state);

  ///
  Future<void> setInputButtonClicked({required bool flag}) async => state = state.copyWith(inputButtonClicked: flag);

  ///
  Future<void> setCreditBlankDefaultMap() async => state = state.copyWith(creditBlankSettingMap: <int, String>{});

  ///
  Future<void> setCreditBlankSettingMap({required int pos, required String creditName}) async {
    final Map<int, String> map = <int, String>{...state.creditBlankSettingMap};
    map[pos] = creditName;
    state = state.copyWith(creditBlankSettingMap: map);
  }

  ///
  Future<void> setHomeListSelectedYearmonth({required String yearmonth}) async => state = state.copyWith(homeListSelectedYearmonth: yearmonth);
}

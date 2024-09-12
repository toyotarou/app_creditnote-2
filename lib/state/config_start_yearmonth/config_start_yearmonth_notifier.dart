import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'config_start_yearmonth_response_state.dart';

final AutoDisposeStateNotifierProvider<ConfigStartYearmonthNotifier, ConfigStartYearmonthResponseState> configStartYearmonthProvider =
    StateNotifierProvider.autoDispose<ConfigStartYearmonthNotifier, ConfigStartYearmonthResponseState>((AutoDisposeStateNotifierProviderRef<ConfigStartYearmonthNotifier, ConfigStartYearmonthResponseState> ref) {
  final int year = DateTime.now().year;
  final List<int> years = <int>[];

  for (int i = year - 3; i <= year; i++) {
    years.add(i);
  }

  // ignore: always_specify_types
  final List<int> months = List.generate(12, (int index) => index);

  return ConfigStartYearmonthNotifier(ConfigStartYearmonthResponseState(startYears: years, startMonths: months));
});

class ConfigStartYearmonthNotifier extends StateNotifier<ConfigStartYearmonthResponseState> {
  ConfigStartYearmonthNotifier(super.state);

  ///
  Future<void> setSelectedYear({required int year}) async => state = state.copyWith(selectedStartYear: year);

  ///
  Future<void> setSelectedMonth({required int month}) async => state = state.copyWith(selectedStartMonth: month);
}

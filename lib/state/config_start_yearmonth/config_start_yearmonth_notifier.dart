import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'config_start_yearmonth_response_state.dart';

final configStartYearmonthProvider =
    StateNotifierProvider.autoDispose<ConfigStartYearmonthNotifier, ConfigStartYearmonthResponseState>((ref) {
  final year = DateTime.now().year;
  final years = <int>[];

  for (var i = year - 3; i <= year; i++) {
    years.add(i);
  }

  final months = List.generate(12, (index) => index);

  return ConfigStartYearmonthNotifier(ConfigStartYearmonthResponseState(startYears: years, startMonths: months));
});

class ConfigStartYearmonthNotifier extends StateNotifier<ConfigStartYearmonthResponseState> {
  ConfigStartYearmonthNotifier(super.state);

  ///
  Future<void> setSelectedYear({required int year}) async => state = state.copyWith(selectedStartYear: year);

  ///
  Future<void> setSelectedMonth({required int month}) async => state = state.copyWith(selectedStartMonth: month);
}

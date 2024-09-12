import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../collections/credit.dart';
import 'credit_response_state.dart';

final AutoDisposeStateNotifierProvider<CreditNotifier, CreditResponseState> creditProvider = StateNotifierProvider.autoDispose<CreditNotifier, CreditResponseState>((AutoDisposeStateNotifierProviderRef<CreditNotifier, CreditResponseState> ref) {
  // ignore: always_specify_types
  final List<String> dates = List.generate(10, (int index) => '');
  // ignore: always_specify_types
  final List<String> names = List.generate(10, (int index) => '');
  // ignore: always_specify_types
  final List<int> prices = List.generate(10, (int index) => -1);

  return CreditNotifier(CreditResponseState(creditDates: dates, creditNames: names, creditPrices: prices));
});

class CreditNotifier extends StateNotifier<CreditResponseState> {
  CreditNotifier(super.state);

  ///
  Future<void> setItemPos({required int pos}) async => state = state.copyWith(itemPos: pos);

  ///
  Future<void> setCreditDate({required int pos, required String date}) async {
    final List<String> dates = <String>[...state.creditDates];
    dates[pos] = date;
    state = state.copyWith(creditDates: dates);
  }

  ///
  Future<void> setCreditName({required int pos, required String name}) async {
    final List<String> names = <String>[...state.creditNames];
    names[pos] = name;
    state = state.copyWith(creditNames: names);
  }

  ///
  Future<void> setCreditPrice({required int pos, required int price}) async {
    final List<int> prices = <int>[...state.creditPrices];
    prices[pos] = price;
    state = state.copyWith(creditPrices: prices);
  }

  ///
  Future<void> clearInputValue() async {
    // ignore: always_specify_types
    final List<String> dates = List.generate(10, (int index) => '');
    // ignore: always_specify_types
    final List<String> names = List.generate(10, (int index) => '');
    // ignore: always_specify_types
    final List<int> prices = List.generate(10, (int index) => 0);

    state = state.copyWith(creditDates: dates, creditNames: names, creditPrices: prices);
  }

  ///
  Future<void> setUpdateCredit({required List<Credit> updateCredit}) async {
    try {
      final List<String> dates = <String>[...state.creditDates];
      final List<String> names = <String>[...state.creditNames];
      final List<int> prices = <int>[...state.creditPrices];

      for (int i = 0; i < updateCredit.length; i++) {
        dates[i] = updateCredit[i].date;
        names[i] = updateCredit[i].name;
        prices[i] = updateCredit[i].price;
      }

      state = state.copyWith(creditDates: dates, creditNames: names, creditPrices: prices);

      // ignore: avoid_catches_without_on_clauses, empty_catches
    } catch (e) {}
  }

  ///
  Future<void> clearOneBox({required int pos}) async {
    final List<String> dates = <String>[...state.creditDates];
    final List<String> names = <String>[...state.creditNames];
    final List<int> prices = <int>[...state.creditPrices];

    dates[pos] = '';
    names[pos] = '';
    prices[pos] = -1;

    state = state.copyWith(creditDates: dates, creditNames: names, creditPrices: prices);
  }
}

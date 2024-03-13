import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'credit_input_response_state.dart';

final creditInputProvider = StateNotifierProvider.autoDispose<CreditInputNotifier, CreditInputResponseState>((ref) {
  final dates = List.generate(10, (index) => '');
  final names = List.generate(10, (index) => '');
  final prices = List.generate(10, (index) => 0);

  return CreditInputNotifier(CreditInputResponseState(creditDates: dates, creditNames: names, creditPrices: prices));
});

class CreditInputNotifier extends StateNotifier<CreditInputResponseState> {
  CreditInputNotifier(super.state);

  ///
  Future<void> setItemPos({required int pos}) async => state = state.copyWith(itemPos: pos);

  ///
  Future<void> setCreditDate({required int pos, required String date}) async {
    final dates = <String>[...state.creditDates];
    dates[pos] = date;
    state = state.copyWith(creditDates: dates);
  }

  ///
  Future<void> setCreditName({required int pos, required String name}) async {
    final names = <String>[...state.creditNames];
    names[pos] = name;
    state = state.copyWith(creditNames: names);
  }

  ///
  Future<void> setCreditPrice({required int pos, required int price}) async {
    final prices = <int>[...state.creditPrices];
    prices[pos] = price;
    state = state.copyWith(creditPrices: prices);
  }
}

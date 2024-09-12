import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';
import 'credit_detail_input_response_state.dart';

final AutoDisposeStateNotifierProvider<CreditDetailInputNotifier, CreditDetailInputResponseState> creditDetailInputProvider = StateNotifierProvider.autoDispose<CreditDetailInputNotifier, CreditDetailInputResponseState>((AutoDisposeStateNotifierProviderRef<CreditDetailInputNotifier, CreditDetailInputResponseState> ref) {
  const int roopNum = 60;

  // ignore: always_specify_types
  final List<String> dates = List.generate(roopNum, (int index) => '');
  // ignore: always_specify_types
  final List<String> items = List.generate(roopNum, (int index) => '');
  // ignore: always_specify_types
  final List<int> prices = List.generate(roopNum, (int index) => 0);
  // ignore: always_specify_types
  final List<String> descriptions = List.generate(roopNum, (int index) => '');

  return CreditDetailInputNotifier(
    CreditDetailInputResponseState(
        creditDetailInputDates: dates, creditDetailInputItems: items, creditDetailInputPrices: prices, creditDetailInputDescriptions: descriptions),
    roopNum: roopNum,
  );
});

class CreditDetailInputNotifier extends StateNotifier<CreditDetailInputResponseState> {
  CreditDetailInputNotifier(super.state, {required this.roopNum});

  final int roopNum;

  ///
  Future<void> setItemPos({required int pos}) async => state = state.copyWith(itemPos: pos);

  ///
  Future<void> setBaseDiff({required String baseDiff}) async => state = state.copyWith(baseDiff: baseDiff);

  ///
  Future<void> setDiff({required int diff}) async => state = state.copyWith(diff: diff);

  ///
  Future<void> setCreditDetailDate({required int pos, required String date}) async {
    final List<String> dates = <String>[...state.creditDetailInputDates];
    dates[pos] = date;
    state = state.copyWith(creditDetailInputDates: dates);
  }

  ///
  Future<void> setCreditDetailItem({required int pos, required String item}) async {
    final List<String> items = <String>[...state.creditDetailInputItems];
    items[pos] = item;
    state = state.copyWith(creditDetailInputItems: items);
  }

  ///
  Future<void> setCreditDetailDescription({required int pos, required String description}) async {
    final List<String> descriptions = <String>[...state.creditDetailInputDescriptions];
    descriptions[pos] = description;
    state = state.copyWith(creditDetailInputDescriptions: descriptions);
  }

  ///
  Future<void> setCreditDetailPrice({required int pos, required int price}) async {
    final List<int> prices = <int>[...state.creditDetailInputPrices];
    prices[pos] = price;

    int sum = 0;
    for (int i = 0; i < prices.length; i++) {
      sum += prices[i];
    }

    final int baseDiff = state.baseDiff.toInt();
    final int diff = baseDiff - sum;

    state = state.copyWith(creditDetailInputPrices: prices, diff: diff);
  }

  ///
  Future<void> clearInputValue() async {
    // ignore: always_specify_types
    final List<String> dates = List.generate(roopNum, (int index) => '');
    // ignore: always_specify_types
    final List<String> items = List.generate(roopNum, (int index) => '');
    // ignore: always_specify_types
    final List<int> prices = List.generate(roopNum, (int index) => 0);
    // ignore: always_specify_types
    final List<String> descriptions = List.generate(roopNum, (int index) => '');

    state = state.copyWith(
        creditDetailInputDates: dates, creditDetailInputItems: items, creditDetailInputPrices: prices, creditDetailInputDescriptions: descriptions);
  }

  ///
  Future<void> setUpdateCreditDetail({required List<CreditDetail> updateCreditDetailList}) async {
    try {
      // ignore: always_specify_types
      final List<String> dates = List.generate(roopNum, (int index) => '');
      // ignore: always_specify_types
      final List<String> items = List.generate(roopNum, (int index) => '');
      // ignore: always_specify_types
      final List<int> prices = List.generate(roopNum, (int index) => 0);
      // ignore: always_specify_types
      final List<String> descriptions = List.generate(roopNum, (int index) => '');

      for (int i = 0; i < updateCreditDetailList.length; i++) {
        dates[i] = updateCreditDetailList[i].creditDetailDate;
        items[i] = updateCreditDetailList[i].creditDetailItem;
        prices[i] = updateCreditDetailList[i].creditDetailPrice;
        descriptions[i] = updateCreditDetailList[i].creditDetailDescription;
      }

      state = state.copyWith(
          creditDetailInputDates: dates, creditDetailInputItems: items, creditDetailInputPrices: prices, creditDetailInputDescriptions: descriptions);

      // ignore: avoid_catches_without_on_clauses, empty_catches
    } catch (e) {}
  }

  ///
  Future<void> clearOneBox({required int pos}) async {
    final List<String> dates = <String>[...state.creditDetailInputDates];
    final List<String> items = <String>[...state.creditDetailInputItems];
    final List<int> prices = <int>[...state.creditDetailInputPrices];
    final List<String> descriptions = <String>[...state.creditDetailInputDescriptions];

    dates[pos] = '';
    items[pos] = '';
    prices[pos] = 0;
    descriptions[pos] = '';

    state = state.copyWith(
        creditDetailInputDates: dates, creditDetailInputItems: items, creditDetailInputPrices: prices, creditDetailInputDescriptions: descriptions);
  }
}

import 'package:credit_note/collections/credit_detail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import 'credit_detail_input_response_state.dart';

final creditDetailProvider = StateNotifierProvider.autoDispose<CreditDetailNotifier, CreditDetailInputResponseState>((ref) {
  const roopNum = 60;

  final dates = List.generate(roopNum, (index) => '');
  final items = List.generate(roopNum, (index) => '');
  final prices = List.generate(roopNum, (index) => 0);
  final descriptions = List.generate(roopNum, (index) => '');

  return CreditDetailNotifier(
    CreditDetailInputResponseState(
        creditDetailInputDates: dates, creditDetailInputItems: items, creditDetailInputPrices: prices, creditDetailInputDescriptions: descriptions),
    roopNum: roopNum,
  );
});

class CreditDetailNotifier extends StateNotifier<CreditDetailInputResponseState> {
  CreditDetailNotifier(super.state, {required this.roopNum});

  final int roopNum;

  ///
  Future<void> setItemPos({required int pos}) async => state = state.copyWith(itemPos: pos);

  ///
  Future<void> setBaseDiff({required String baseDiff}) async => state = state.copyWith(baseDiff: baseDiff);

  ///
  Future<void> setCreditDetailDate({required int pos, required String date}) async {
    final dates = <String>[...state.creditDetailInputDates];
    dates[pos] = date;
    state = state.copyWith(creditDetailInputDates: dates);
  }

  ///
  Future<void> setCreditDetailItem({required int pos, required String item}) async {
    final items = <String>[...state.creditDetailInputItems];
    items[pos] = item;
    state = state.copyWith(creditDetailInputItems: items);
  }

  ///
  Future<void> setCreditDetailDescription({required int pos, required String description}) async {
    final descriptions = <String>[...state.creditDetailInputDescriptions];
    descriptions[pos] = description;
    state = state.copyWith(creditDetailInputDescriptions: descriptions);
  }

  ///
  Future<void> setCreditDetailPrice({required int pos, required int price}) async {
    final prices = <int>[...state.creditDetailInputPrices];
    prices[pos] = price;

    var sum = 0;
    for (var i = 0; i < prices.length; i++) {
      sum += prices[i];
    }

    final baseDiff = state.baseDiff.toInt();
    final diff = baseDiff - sum;

    state = state.copyWith(creditDetailInputPrices: prices, diff: diff);
  }

  ///
  Future<void> clearInputValue() async {
    final dates = List.generate(roopNum, (index) => '');
    final items = List.generate(roopNum, (index) => '');
    final prices = List.generate(roopNum, (index) => 0);
    final descriptions = List.generate(roopNum, (index) => '');

    state = state.copyWith(
      creditDetailInputDates: dates,
      creditDetailInputItems: items,
      creditDetailInputPrices: prices,
      creditDetailInputDescriptions: descriptions,
    );
  }

  ///
  Future<void> setUpdateCreditDetail({required List<CreditDetail> updateCreditDetail}) async {
    try {
      final dates = List.generate(roopNum, (index) => '');
      final items = List.generate(roopNum, (index) => '');
      final prices = List.generate(roopNum, (index) => 0);
      final descriptions = List.generate(roopNum, (index) => '');

      for (var i = 0; i < updateCreditDetail.length; i++) {
        dates[i] = updateCreditDetail[i].creditDetailDate;
        items[i] = updateCreditDetail[i].creditDetailItem;
        prices[i] = updateCreditDetail[i].creditDetailPrice;
        descriptions[i] = updateCreditDetail[i].creditDetailDescription;
      }

      state = state.copyWith(
        creditDetailInputDates: dates,
        creditDetailInputItems: items,
        creditDetailInputPrices: prices,
        creditDetailInputDescriptions: descriptions,
      );

      // ignore: avoid_catches_without_on_clauses, empty_catches
    } catch (e) {}
  }

  ///
  Future<void> clearOneBox({required int pos}) async {
    final dates = <String>[...state.creditDetailInputDates];
    final items = <String>[...state.creditDetailInputItems];
    final prices = <int>[...state.creditDetailInputPrices];
    final descriptions = <String>[...state.creditDetailInputDescriptions];

    dates[pos] = '';
    items[pos] = '';
    prices[pos] = 0;
    descriptions[pos] = '';

    state = state.copyWith(
      creditDetailInputDates: dates,
      creditDetailInputItems: items,
      creditDetailInputPrices: prices,
      creditDetailInputDescriptions: descriptions,
    );
  }
}

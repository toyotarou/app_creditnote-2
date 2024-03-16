import 'package:credit_note/collections/credit_detail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import 'credit_detail_response_state.dart';

final creditDetailProvider = StateNotifierProvider.autoDispose<CreditDetailNotifier, CreditDetailResponseState>((ref) {
  const roopNum = 60;

  final dates = List.generate(roopNum, (index) => '');
  final items = List.generate(roopNum, (index) => '');
  final prices = List.generate(roopNum, (index) => 0);
  final descriptions = List.generate(roopNum, (index) => '');

  return CreditDetailNotifier(
    CreditDetailResponseState(
      creditDetailDates: dates,
      creditDetailItems: items,
      creditDetailPrices: prices,
      creditDetailDescriptions: descriptions,
    ),
    roopNum: roopNum,
  );
});

class CreditDetailNotifier extends StateNotifier<CreditDetailResponseState> {
  CreditDetailNotifier(super.state, {required this.roopNum});

  final int roopNum;

  ///
  Future<void> setItemPos({required int pos}) async => state = state.copyWith(itemPos: pos);

  ///
  Future<void> setBaseDiff({required String baseDiff}) async => state = state.copyWith(baseDiff: baseDiff);

  ///
  Future<void> setCreditDetailDate({required int pos, required String date}) async {
    final dates = <String>[...state.creditDetailDates];
    dates[pos] = date;
    state = state.copyWith(creditDetailDates: dates);
  }

  ///
  Future<void> setCreditDetailItem({required int pos, required String item}) async {
    final items = <String>[...state.creditDetailItems];
    items[pos] = item;
    state = state.copyWith(creditDetailItems: items);
  }

  ///
  Future<void> setCreditDetailDescription({required int pos, required String description}) async {
    final descriptions = <String>[...state.creditDetailDescriptions];
    descriptions[pos] = description;
    state = state.copyWith(creditDetailDescriptions: descriptions);
  }

  ///
  Future<void> setCreditDetailPrice({required int pos, required int price}) async {
    final prices = <int>[...state.creditDetailPrices];
    prices[pos] = price;

    var sum = 0;
    for (var i = 0; i < prices.length; i++) {
      sum += prices[i];
    }

    final baseDiff = state.baseDiff.toInt();
    final diff = baseDiff - sum;

    state = state.copyWith(creditDetailPrices: prices, diff: diff);
  }

  ///
  Future<void> clearInputValue() async {
    final dates = List.generate(roopNum, (index) => '');
    final items = List.generate(roopNum, (index) => '');
    final prices = List.generate(roopNum, (index) => 0);
    final descriptions = List.generate(roopNum, (index) => '');

    state = state.copyWith(
      creditDetailDates: dates,
      creditDetailItems: items,
      creditDetailPrices: prices,
      creditDetailDescriptions: descriptions,
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
        creditDetailDates: dates,
        creditDetailItems: items,
        creditDetailPrices: prices,
        creditDetailDescriptions: descriptions,
      );

      // ignore: avoid_catches_without_on_clauses, empty_catches
    } catch (e) {}
  }
}

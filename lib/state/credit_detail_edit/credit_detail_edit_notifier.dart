import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'credit_detail_edit_response_state.dart';

final creditDetailInputProvider = StateNotifierProvider.autoDispose<CreditDetailEditNotifier, CreditDetailEditResponseState>((ref) {
  return CreditDetailEditNotifier(const CreditDetailEditResponseState());
});

class CreditDetailEditNotifier extends StateNotifier<CreditDetailEditResponseState> {
  CreditDetailEditNotifier(super.state);

  ///
  Future<void> setCreditDetailDate({required String date}) async => state = state.copyWith(creditDetailEditDate: date);

  ///
  Future<void> setCreditDetailItem({required String item}) async => state = state.copyWith(creditDetailEditItem: item);

  ///
  Future<void> setCreditDetailPrice({required int price}) async => state = state.copyWith(creditDetailEditPrice: price);

  ///
  Future<void> setCreditDetailDescription({required String description}) async => state = state.copyWith(creditDetailEditDescription: description);
}

import 'package:isar/isar.dart';

import '../collections/credit_detail.dart';

class CreditDetailsRepository {
  ///
  IsarCollection<CreditDetail> getCollection({required Isar isar}) =>
      isar.creditDetails;

  Future<CreditDetail?> getCreditDetail(
      {required Isar isar, required int id}) async {
    final IsarCollection<CreditDetail> creditDetailsCollection =
        getCollection(isar: isar);
    return creditDetailsCollection.get(id);
  }

  ///
  Future<List<CreditDetail>?> getCreditDetailList({required Isar isar}) async {
    final IsarCollection<CreditDetail> creditDetailsCollection =
        getCollection(isar: isar);
    return creditDetailsCollection
        .where()
        .sortByCreditDate()
        .thenByCreditPriceDesc()
        .findAll();
  }

  ///
  Future<List<CreditDetail>?> getCreditDetailListByDateAndPrice(
      {required Isar isar, required Map<String, dynamic> param}) async {
    final IsarCollection<CreditDetail> creditDetailsCollection =
        getCollection(isar: isar);
    return creditDetailsCollection
        .filter()
        .creditDateEqualTo(param['date'] as String)
        .creditPriceEqualTo(param['price'] as String)
        .sortByCreditDetailDate()
        .findAll();
  }

  ///
  Future<void> inputCreditDetailList(
      {required Isar isar,
      required List<CreditDetail> creditDetailList}) async {
    for (final CreditDetail element in creditDetailList) {
      inputCreditDetail(isar: isar, creditDetail: element);
    }
  }

  ///
  Future<void> inputCreditDetail(
      {required Isar isar, required CreditDetail creditDetail}) async {
    final IsarCollection<CreditDetail> creditDetailsCollection =
        getCollection(isar: isar);
    await isar.writeTxn(() async => creditDetailsCollection.put(creditDetail));
  }

  ///
  Future<void> updateCreditDetailList(
      {required Isar isar,
      required List<CreditDetail> creditDetailList}) async {
    for (final CreditDetail element in creditDetailList) {
      updateCreditDetail(isar: isar, creditDetail: element);
    }
  }

  ///
  Future<void> updateCreditDetail(
      {required Isar isar, required CreditDetail creditDetail}) async {
    final IsarCollection<CreditDetail> creditDetailsCollection =
        getCollection(isar: isar);
    await creditDetailsCollection.put(creditDetail);
  }

  ///
  Future<void> deleteCreditDetailList(
      {required Isar isar,
      required List<CreditDetail>? creditDetailList}) async {
    creditDetailList?.forEach((CreditDetail element) =>
        deleteCreditDetail(isar: isar, id: element.id));
  }

  ///
  Future<void> deleteCreditDetail({required Isar isar, required int id}) async {
    final IsarCollection<CreditDetail> creditDetailsCollection =
        getCollection(isar: isar);
    await isar.writeTxn(() async => creditDetailsCollection.delete(id));
  }
}

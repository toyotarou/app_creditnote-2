import 'package:isar/isar.dart';

import '../collections/credit_detail.dart';

class CreditDetailsRepository {
  ///
  IsarCollection<CreditDetail> getCollection({required Isar isar}) => isar.creditDetails;

  Future<CreditDetail?> getCreditDetail({required Isar isar, required int id}) async {
    final creditDetailsCollection = getCollection(isar: isar);
    return creditDetailsCollection.get(id);
  }

  ///
  Future<List<CreditDetail>?> getCreditDetailList({required Isar isar}) async {
    final creditDetailsCollection = getCollection(isar: isar);
    return creditDetailsCollection.where().sortByCreditDate().thenByCreditPriceDesc().findAll();
  }

  ///
  Future<List<CreditDetail>?> getCreditDetailListByDateAndPrice({required Isar isar, required Map<String, dynamic> param}) async {
    final creditDetailsCollection = getCollection(isar: isar);
    return creditDetailsCollection.filter().creditDateEqualTo(param['date']).creditPriceEqualTo(param['price']).sortByCreditDetailDate().findAll();
  }

  ///
  Future<void> inputCreditDetailList({required Isar isar, required List<CreditDetail> creditDetailList}) async {
    creditDetailList.forEach((element) {
      inputCreditDetail(isar: isar, creditDetail: element);
    });
  }

  ///
  Future<void> inputCreditDetail({required Isar isar, required CreditDetail creditDetail}) async {
    final creditDetailsCollection = getCollection(isar: isar);
    await isar.writeTxn(() async => creditDetailsCollection.put(creditDetail));
  }

  ///
  Future<void> updateCreditDetailList({required Isar isar, required List<CreditDetail> creditDetailList}) async {
    creditDetailList.forEach((element) {
      updateCreditDetail(isar: isar, creditDetail: element);
    });
  }

  ///
  Future<void> updateCreditDetail({required Isar isar, required CreditDetail creditDetail}) async {
    final creditDetailsCollection = getCollection(isar: isar);
    await creditDetailsCollection.put(creditDetail);
  }

  ///
  Future<void> deleteCreditDetailList({required Isar isar, required List<CreditDetail>? creditDetailList}) async {
    creditDetailList?.forEach((element) => deleteCreditDetail(isar: isar, id: element.id));
  }

  ///
  Future<void> deleteCreditDetail({required Isar isar, required int id}) async {
    final creditDetailsCollection = getCollection(isar: isar);
    await isar.writeTxn(() async => creditDetailsCollection.delete(id));
  }
}

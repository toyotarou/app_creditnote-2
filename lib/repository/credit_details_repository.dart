import 'package:isar/isar.dart';

import '../collections/credit_detail.dart';

class CreditDetailsRepository {
  ///
  IsarCollection<CreditDetail> getCollection({required Isar isar}) => isar.creditDetails;

  ///
  Future<List<CreditDetail>?> getCreditDetailList({required Isar isar, required Map<String, dynamic> param}) async {
    final creditDetailsCollection = getCollection(isar: isar);
    return creditDetailsCollection
        .filter()
        .creditDateEqualTo(param['date'])
        .creditPriceEqualTo(param['price'])
        .findAll();
  }

  ///
  Future<void> updateCreditDetailList({required Isar isar, required List<CreditDetail> creditDetailList}) async =>
      creditDetailList.forEach((element) => updateCreditDetail(isar: isar, creditDetail: element));

  ///
  Future<void> updateCreditDetail({required Isar isar, required CreditDetail creditDetail}) async {
    final creditDetailsCollection = getCollection(isar: isar);
    await creditDetailsCollection.put(creditDetail);
  }
}

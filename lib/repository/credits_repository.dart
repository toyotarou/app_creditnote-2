import 'package:isar/isar.dart';

import '../collections/credit.dart';

class CreditsRepository {
  ///
  IsarCollection<Credit> getCollection({required Isar isar}) => isar.credits;

  ///
  Future<List<Credit>?> getCreditList({required Isar isar}) async {
    final IsarCollection<Credit> creditsCollection = getCollection(isar: isar);
    return creditsCollection.where().sortByDate().thenByPriceDesc().findAll();
  }

  ///
  Future<Credit?> getCreditByDateAndPrice(
      {required Isar isar, required Map<String, dynamic> param}) async {
    final IsarCollection<Credit> creditsCollection = getCollection(isar: isar);
    return creditsCollection
        .filter()
        .dateEqualTo(param['date'] as String)
        .priceEqualTo(param['price'] as int)
        .findFirst();
  }

  ///
  Future<void> inputCreditList(
      {required Isar isar, required List<Credit> creditList}) async {
    for (final Credit element in creditList) {
      inputCredit(isar: isar, credit: element);
    }
  }

  ///
  Future<void> inputCredit({required Isar isar, required Credit credit}) async {
    final IsarCollection<Credit> creditsCollection = getCollection(isar: isar);
    await isar.writeTxn(() async => creditsCollection.put(credit));
  }

  ///
  Future<void> updateCredit(
      {required Isar isar, required Credit credit}) async {
    final IsarCollection<Credit> creditsCollection = getCollection(isar: isar);
    await creditsCollection.put(credit);
  }

  ///
  Future<void> deleteCreditList(
      {required Isar isar, required List<Credit> creditList}) async {
    for (final Credit element in creditList) {
      deleteCredit(isar: isar, id: element.id);
    }
  }

  ///
  Future<void> deleteCredit({required Isar isar, required int id}) async {
    final IsarCollection<Credit> creditsCollection = getCollection(isar: isar);
    await isar.writeTxn(() async => creditsCollection.delete(id));
  }
}

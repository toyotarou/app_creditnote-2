import 'package:isar/isar.dart';

import '../collections/credit.dart';

class CreditRepository {
  ///
  IsarCollection<Credit> getCollection({required Isar isar}) => isar.credits;

  ///
  Future<void> inputCreditList({required Isar isar, required List<Credit> creditList}) async {
    creditList.forEach((element) => inputCredit(isar: isar, credit: element));
  }

  ///
  Future<void> inputCredit({required Isar isar, required Credit credit}) async {
    final creditsCollection = getCollection(isar: isar);
    await isar.writeTxn(() async => creditsCollection.put(credit));
  }

  ///
  Future<void> deleteCreditList({required Isar isar, required List<Credit> creditList}) async {
    creditList.forEach((element) => deleteCredit(isar: isar, id: element.id));
  }

  ///
  Future<void> deleteCredit({required Isar isar, required int id}) async {
    final creditsCollection = getCollection(isar: isar);
    await isar.writeTxn(() async => creditsCollection.delete(id));
  }
}

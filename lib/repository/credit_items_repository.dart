import 'package:isar/isar.dart';

import '../collections/credit_item.dart';

class CreditItemsRepository {
  ///
  IsarCollection<CreditItem> getCollection({required Isar isar}) => isar.creditItems;

  ///
  Future<CreditItem?> getCreditItem({required Isar isar, required int id}) async {
    final IsarCollection<CreditItem> creditItemsCollection = getCollection(isar: isar);
    return creditItemsCollection.get(id);
  }

  ///
  Future<List<CreditItem>?> getCreditItemList({required Isar isar}) async {
    final IsarCollection<CreditItem> creditItemsCollection = getCollection(isar: isar);
    return creditItemsCollection.where().sortByOrder().findAll();
  }

  ///
  Future<void> inputCreditItem({required Isar isar, required CreditItem creditItem}) async {
    final IsarCollection<CreditItem> creditItemsCollection = getCollection(isar: isar);
    await isar.writeTxn(() async => creditItemsCollection.put(creditItem));
  }

  ///
  Future<void> updateCreditItem({required Isar isar, required CreditItem creditItem}) async {
    final IsarCollection<CreditItem> creditItemsCollection = getCollection(isar: isar);
    await creditItemsCollection.put(creditItem);
  }
}

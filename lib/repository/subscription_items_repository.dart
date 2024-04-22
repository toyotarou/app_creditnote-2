import 'package:isar/isar.dart';

import '../collections/subscription_item.dart';

class SubscriptionItemsRepository {
  ///
  IsarCollection<SubscriptionItem> getCollection({required Isar isar}) => isar.subscriptionItems;

  ///
  Future<SubscriptionItem?> getSubscriptionItemByName({required Isar isar, required String name}) async {
    final subscriptionItemsCollection = getCollection(isar: isar);
    return subscriptionItemsCollection.filter().nameEqualTo(name).findFirst();
  }

  ///
  Future<void> inputSubscriptionItem({required Isar isar, required SubscriptionItem subscriptionItem}) async {
    final subscriptionItemsCollection = getCollection(isar: isar);
    await isar.writeTxn(() async => subscriptionItemsCollection.put(subscriptionItem));
  }

  ///
  Future<void> deleteSubscriptionItem({required Isar isar, required int id}) async {
    final subscriptionItemsCollection = getCollection(isar: isar);
    await isar.writeTxn(() async => subscriptionItemsCollection.delete(id));
  }
}

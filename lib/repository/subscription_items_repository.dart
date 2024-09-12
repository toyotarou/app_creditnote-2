import 'package:isar/isar.dart';

import '../collections/subscription_item.dart';

class SubscriptionItemsRepository {
  ///
  IsarCollection<SubscriptionItem> getCollection({required Isar isar}) =>
      isar.subscriptionItems;

  ///
  Future<SubscriptionItem?> getSubscriptionItemByName(
      {required Isar isar, required String name}) async {
    final IsarCollection<SubscriptionItem> subscriptionItemsCollection =
        getCollection(isar: isar);
    return subscriptionItemsCollection.filter().nameEqualTo(name).findFirst();
  }

  ///
  Future<List<SubscriptionItem>?> getSubscriptionItemList(
      {required Isar isar}) async {
    final IsarCollection<SubscriptionItem> subscriptionItemsCollection =
        getCollection(isar: isar);
    return subscriptionItemsCollection.where().findAll();
  }

  ///
  Future<void> inputSubscriptionItemList(
      {required Isar isar,
      required List<SubscriptionItem> subscriptionItemList}) async {
    for (final SubscriptionItem element in subscriptionItemList) {
      inputSubscriptionItem(isar: isar, subscriptionItem: element);
    }
  }

  ///
  Future<void> inputSubscriptionItem(
      {required Isar isar, required SubscriptionItem subscriptionItem}) async {
    final IsarCollection<SubscriptionItem> subscriptionItemsCollection =
        getCollection(isar: isar);
    await isar.writeTxn(
        () async => subscriptionItemsCollection.put(subscriptionItem));
  }

  ///
  Future<void> deleteSubscriptionItem(
      {required Isar isar, required int id}) async {
    final IsarCollection<SubscriptionItem> subscriptionItemsCollection =
        getCollection(isar: isar);
    await isar.writeTxn(() async => subscriptionItemsCollection.delete(id));
  }
}

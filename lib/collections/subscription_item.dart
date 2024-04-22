import 'package:isar/isar.dart';

part 'subscription_item.g.dart';

@collection
class SubscriptionItem {
  Id id = Isar.autoIncrement;

  late String name;
}

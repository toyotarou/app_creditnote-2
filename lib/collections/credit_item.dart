import 'package:isar/isar.dart';

part 'credit_item.g.dart';

@collection
class CreditItem {
  Id id = Isar.autoIncrement;

  late String name;

  late int order;

  late String color;
}

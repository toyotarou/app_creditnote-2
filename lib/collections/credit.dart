import 'package:isar/isar.dart';

part 'credit.g.dart';

@collection
class Credit {
  Id id = Isar.autoIncrement;

  @Index()
  late String date;

  late String name;

  late int price;
}

import 'package:isar/isar.dart';

part 'credit_detail.g.dart';

@collection
class CreditDetail {
  Id id = Isar.autoIncrement;

  @Index()
  late String yearmonth;

  @Index()
  late String creditDate;

  late String creditPrice;

  @Index()
  late String creditDetailDate;

  late String creditDetailItem;
  late String creditDetailDescription;
  late int creditDetailPrice;
}

import 'package:credit_note/collections/subscription_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../collections/credit_item.dart';
import '../../extensions/extensions.dart';
import '../../repository/subscription_items_repository.dart';
import 'credit_detail_edit_alert.dart';
import 'parts/credit_dialog.dart';

class SameItemListAlert extends ConsumerStatefulWidget {
  const SameItemListAlert({super.key, required this.isar, required this.creditDetail, required this.creditDetailList, required this.creditItemList});

  final Isar isar;
  final CreditDetail creditDetail;
  final List<CreditDetail>? creditDetailList;
  final List<CreditItem> creditItemList;

  @override
  ConsumerState<SameItemListAlert> createState() => _SameItemListAlertState();
}

class _SameItemListAlertState extends ConsumerState<SameItemListAlert> {
  ///
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: GoogleFonts.kiwiMaru(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.creditDetail.creditDetailDescription),
                  GestureDetector(
                    onTap: subscriptionItemInputDeleteToggle,
                    child: const Icon(Icons.settings_applications_sharp),
                  ),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: _displaySameItemCreditDetailList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displaySameItemCreditDetailList() {
    final list = <Widget>[];

    final spendItemColorMap = <String, String>{};
    widget.creditItemList.forEach((element) => spendItemColorMap[element.name] = element.color);

    widget.creditDetailList!.where((element) => element.creditDetailDescription == widget.creditDetail.creditDetailDescription).toList()
      ..sort((a, b) {
        final result = a.creditDetailDate.compareTo(b.creditDetailDate);
        if (result != 0) {
          return result;
        }
        return -1 * a.creditDetailPrice.compareTo(b.creditDetailPrice);
      })
      ..forEach((element) {
        final lineColor = (spendItemColorMap[element.creditDetailItem] != null && spendItemColorMap[element.creditDetailItem] != '')
            ? spendItemColorMap[element.creditDetailItem]
            : '0xffffffff';

        list.add(Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            children: [
              Expanded(child: Text(element.creditDetailDate)),
              Expanded(child: Container(alignment: Alignment.topRight, child: Text(element.creditDetailPrice.toString().toCurrency()))),
              const SizedBox(width: 20),
              Container(
                width: context.screenSize.width / 6,
                margin: const EdgeInsets.symmetric(vertical: 3),
                padding: const EdgeInsets.symmetric(vertical: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Color(lineColor!.toInt()).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                child: FittedBox(child: Text(element.creditDetailItem, style: const TextStyle(fontSize: 10))),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  CreditDialog(
                    context: context,
                    widget: CreditDetailEditAlert(
                        isar: widget.isar, creditDetail: element, creditItemList: widget.creditItemList, from: 'SameItemListAlert'),
                  );
                },
                child: Icon(Icons.edit, color: Colors.greenAccent.withOpacity(0.4), size: 16),
              ),
            ],
          ),
        ));
      });

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  Future<void> subscriptionItemInputDeleteToggle() async {
    await SubscriptionItemsRepository().getSubscriptionItemByName(isar: widget.isar, name: widget.creditDetail.creditDetailDescription).then((value) {
      if (value == null) {
        final subscriptionItem = SubscriptionItem()..name = widget.creditDetail.creditDetailDescription;
        SubscriptionItemsRepository().inputSubscriptionItem(isar: widget.isar, subscriptionItem: subscriptionItem);
      } else {
        SubscriptionItemsRepository().deleteSubscriptionItem(isar: widget.isar, id: value.id);
      }
    });
  }
}

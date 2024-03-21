import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../collections/credit_item.dart';
import '../../extensions/extensions.dart';

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
                children: [Text(widget.creditDetail.creditDetailDescription), Container()],
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
    widget.creditItemList.forEach((element) {
      spendItemColorMap[element.name] = element.color;
    });

    widget.creditDetailList!.where((element) => element.creditDetailDescription == widget.creditDetail.creditDetailDescription).toList()
      ..sort((a, b) => a.creditDetailDate.compareTo(b.creditDetailDate))
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
                child: Text(element.creditDetailItem, style: const TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ));
      });

    return SingleChildScrollView(child: Column(children: list));
  }
}

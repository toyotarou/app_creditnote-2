import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';

class MonthlyCreditItemListAlert extends ConsumerStatefulWidget {
  const MonthlyCreditItemListAlert({super.key, required this.date, required this.isar, required this.item, required this.creditDetailList});

  final DateTime date;
  final Isar isar;
  final String item;
  final List<CreditDetail> creditDetailList;

  @override
  ConsumerState<MonthlyCreditItemListAlert> createState() => _MonthlyCreditItemListAlertState();
}

class _MonthlyCreditItemListAlertState extends ConsumerState<MonthlyCreditItemListAlert> {
  ///
  @override
  Widget build(BuildContext context) {
    int sum = 0;

    if (widget.creditDetailList.isNotEmpty) {
      widget.creditDetailList
          .where((CreditDetail element) => DateTime.parse('${element.creditDate} 00:00:00').yyyymm == widget.date.yyyymm)
          .toList()
          .where((CreditDetail element2) => element2.creditDetailItem == widget.item)
          .forEach((CreditDetail element3) {
        sum += element3.creditDetailPrice;
      });
    }

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
            children: <Widget>[
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text(widget.date.yyyymmdd), Text(widget.item)],
                  ),
                  Text(sum.toString().toCurrency()),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: _displayMonthlyCreditItemList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayMonthlyCreditItemList() {
    final List<Widget> list = <Widget>[];

    if (widget.creditDetailList.isNotEmpty) {
      widget.creditDetailList
          .where((CreditDetail element) => DateTime.parse('${element.creditDate} 00:00:00').yyyymm == widget.date.yyyymm)
          .toList()
          .where((CreditDetail element2) => element2.creditDetailItem == widget.item)
          .toList()
        ..sort((CreditDetail a, CreditDetail b) => a.creditDetailDate.compareTo(b.creditDetailDate))
        ..forEach((CreditDetail element3) {
          list.add(Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
            child: Row(
              children: <Widget>[
                SizedBox(width: 100, child: Text(element3.creditDetailDate)),
                Expanded(child: (element3.creditDetailDescription == widget.item) ? Container() : Text(element3.creditDetailDescription)),
                Container(
                  width: 50,
                  alignment: Alignment.topRight,
                  child: Text(element3.creditDetailPrice.toString().toCurrency()),
                ),
              ],
            ),
          ));
        });
    }

    return SingleChildScrollView(child: Column(children: list));
  }
}

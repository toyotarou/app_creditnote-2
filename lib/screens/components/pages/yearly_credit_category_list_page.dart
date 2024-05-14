import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../../collections/credit_detail.dart';
import '../../../collections/credit_item.dart';
import '../../../extensions/extensions.dart';

class YearlyCreditCategoryListPage extends StatefulWidget {
  const YearlyCreditCategoryListPage(
      {super.key,
      required this.isar,
      required this.date,
      required this.creditItemList,
      required this.creditDetailList});

  final Isar isar;
  final DateTime date;
  final List<CreditItem>? creditItemList;
  final List<CreditDetail>? creditDetailList;

  @override
  State<YearlyCreditCategoryListPage> createState() => _YearlyCreditCategoryListPageState();
}

class _YearlyCreditCategoryListPageState extends State<YearlyCreditCategoryListPage> {
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
              const SizedBox(height: 10),
              Container(width: context.screenSize.width),
              Expanded(child: _displayYearlyCreditCategoryList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayYearlyCreditCategoryList() {
    final monthSumMap = <int, int>{};
    widget.creditItemList?.forEach((element) {
      for (var i = 1; i <= 12; i++) {
        final filtered = widget.creditDetailList
            ?.where((element2) => element2.yearmonth == '${widget.date.year}-${i.toString().padLeft(2, '0')}')
            .toList();

        var sum = 0;
        filtered?.forEach((element) {
          sum += element.creditDetailPrice;
        });

        monthSumMap[i] = sum;
      }
    });

    final creditCategoryMap = <String, List<String>>{};

    widget.creditItemList?.forEach((element) {
      creditCategoryMap[element.name] = [];
    });

    widget.creditItemList?.forEach((element) {
      for (var i = 1; i <= 12; i++) {
        final filtered = widget.creditDetailList
            ?.where((element2) => element2.yearmonth == '${widget.date.year}-${i.toString().padLeft(2, '0')}')
            .toList();

        //=====================================
        var sum = 0;
        if (filtered!.isNotEmpty) {
          final filtered2 = filtered.where((element3) => element.name == element3.creditDetailItem).toList();

          if (filtered2.isNotEmpty) {
            filtered2.forEach((element4) => sum += element4.creditDetailPrice);
          }
        }
        //=====================================

        creditCategoryMap[element.name]?.add(sum.toString().toCurrency());
      }
    });

    const valueDevide = 5;

    final list = <Widget>[
      Row(
        children: [
          Container(
            width: context.screenSize.width / 6,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 3),
            alignment: Alignment.topRight,
            child: const Text('', style: TextStyle(fontSize: 10)),
          ),
          const SizedBox(width: 10),
          for (var i = 0; i < 12; i++) ...[
            Container(
              width: context.screenSize.width / valueDevide,
              padding: const EdgeInsets.all(1),
              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 1),
              alignment: Alignment.center,
              child: Text((i + 1).toString()),
            ),
          ],
        ],
      ),
    ];

    final creditItemColorMap = <String, String>{};
    widget.creditItemList?.forEach((element) {
      creditItemColorMap[element.name] = element.color;
    });

    widget.creditItemList?.forEach((element) {
      final lineColor = (creditItemColorMap[element.name] != null && creditItemColorMap[element.name] != '')
          ? creditItemColorMap[element.name]
          : '0xffffffff';

      var sum = 0;

      if (creditCategoryMap[element.name] != null) {
        for (var i = 0; i < 12; i++) {
          if (creditCategoryMap[element.name]![i].isNotEmpty) {
            sum += creditCategoryMap[element.name]![i].replaceAll(',', '').toInt();
          }
        }
      }

      if (sum > 0) {
        final list2 = <Widget>[
          Container(
            width: context.screenSize.width / 6,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(lineColor!.toInt()).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child: FittedBox(child: Text(element.name, style: const TextStyle(fontSize: 10))),
          ),
          const SizedBox(width: 10),
        ];

        if (creditCategoryMap[element.name] != null) {
          for (var i = 0; i < 12; i++) {
            if (creditCategoryMap[element.name]![i].isNotEmpty) {
              list2.add(
                Container(
                  width: context.screenSize.width / valueDevide,
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 1),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent, width: 2),
                    color: Color(lineColor.toInt()).withOpacity(0.1),
                  ),
                  alignment: Alignment.topRight,
                  child: Text(creditCategoryMap[element.name]![i]),
                ),
              );
            }
          }
        }

        list2.add(
          Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: context.screenSize.width / 6,
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 1),
                padding: const EdgeInsets.symmetric(vertical: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(lineColor.toInt()).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                child: Text(element.name, style: const TextStyle(fontSize: 10)),
              ),
            ],
          ),
        );

        list.add(Row(children: list2));
      }
    });

    list.add(
      Row(
        children: [
          Container(
            width: context.screenSize.width / 6,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 3),
            alignment: Alignment.topRight,
            child: const Text('', style: TextStyle(fontSize: 10)),
          ),
          const SizedBox(width: 10),
          for (var i = 0; i < 12; i++) ...[
            Container(
              width: context.screenSize.width / valueDevide,
              padding: const EdgeInsets.all(1),
              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 1),
              alignment: Alignment.topRight,
              child: Text((monthSumMap[(i + 1)] != null) ? monthSumMap[(i + 1)].toString().toCurrency() : '0'),
            ),
          ],
        ],
      ),
    );

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list));
  }
}

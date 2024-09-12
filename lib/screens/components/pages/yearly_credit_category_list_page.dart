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
  State<YearlyCreditCategoryListPage> createState() =>
      _YearlyCreditCategoryListPageState();
}

class _YearlyCreditCategoryListPageState
    extends State<YearlyCreditCategoryListPage> {
  List<CreditDetail> cdList = <CreditDetail>[];

  ///
  @override
  void initState() {
    super.initState();

    if (widget.creditDetailList != null) {
      cdList = widget.creditDetailList!
          .where((CreditDetail element) =>
              element.yearmonth.split('-')[0].toInt() == widget.date.year)
          .toList();
    }
  }

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
            children: <Widget>[
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
    final List<Widget> list = <Widget>[];

    Column underWidget = const Column();

    if (widget.creditItemList != null) {
      final Map<int, Map<String, int>> map = <int, Map<String, int>>{};

      for (int i = 1; i <= 12; i++) {
        final Map<String, List<int>> map2 = <String, List<int>>{};

        for (final CreditItem element2 in widget.creditItemList!) {
          map2[element2.name] = <int>[];
        }

        for (final CreditDetail element in cdList) {
          final String widgetYearmonth =
              '${widget.date.year}-${i.toString().padLeft(2, '0')}';

          if (element.yearmonth == widgetYearmonth) {
            for (final CreditItem element2 in widget.creditItemList!) {
              if (element.creditDetailItem == element2.name) {
                map2[element2.name]?.add(element.creditDetailPrice);
              }
            }
          }
        }

        final Map<String, int> map3 = <String, int>{};

        for (final CreditItem element4 in widget.creditItemList!) {
          map3[element4.name] = 0;
        }

        map2.forEach((String key, List<int> value) {
          int sum = 0;
          for (final int element3 in value) {
            sum += element3;
          }
          map3[key] = sum;
        });

        map[i] = map3;
      }

      final List<Widget> list2 = <Widget>[const SizedBox(width: 140)];

      for (int i = 1; i <= 12; i++) {
        final List<Widget> list3 = <Widget>[];

        int sum = 0;

        if (DateTime(widget.date.year, i).isBefore(DateTime.now())) {
          list3.add(
            Container(
              width: 100,
              height: 30,
              alignment: Alignment.center,
              child: Text(i.toString().padLeft(2, '0')),
            ),
          );

          for (final CreditItem element5 in widget.creditItemList!) {
            list3.add(Container(
              width: 100,
              height: 24,
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color(element5.color.toInt()).withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          (map[i] != null && map[i]![element5.name] != null)
                              ? map[i]![element5.name]!.toString().toCurrency()
                              : '',
                        ),
                      ),
                      Text(
                        i.toString().padLeft(2, '0'),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ));

            sum += (map[i] != null && map[i]![element5.name] != null)
                ? map[i]![element5.name]!
                : 0;
          }

          list3.add(Container(
            width: 100,
            height: 24,
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            padding: const EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(sum.toString().toCurrency()),
                ),
              ],
            ),
          ));
        }

        list2.add(Column(children: list3));
      }

      list.add(Row(children: list2));

      underWidget = Column(
        children: <Widget>[
          const SizedBox(width: 100, height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.creditItemList!.map((CreditItem e) {
              return Container(
                width: 120,
                height: 24,
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Color(e.color.toInt()).withOpacity(0.1),
                ),
                child: Text(e.name),
              );
            }).toList(),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          underWidget,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(children: list),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../collections/credit_item.dart';
import 'pages/yearly_credit_category_list_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class YearlyCreditCategoryListAlert extends StatefulWidget {
  const YearlyCreditCategoryListAlert({
    super.key,
    required this.isar,
    required this.creditItemList,
    required this.creditDetailList,
    required this.selectedYearmonthList,
  });

  final Isar isar;
  final List<CreditItem>? creditItemList;
  final List<CreditDetail>? creditDetailList;
  final List<String> selectedYearmonthList;

  @override
  State<YearlyCreditCategoryListAlert> createState() => _YearlyCreditCategoryListAlertState();
}

class _YearlyCreditCategoryListAlertState extends State<YearlyCreditCategoryListAlert> {
  final List<TabInfo> tabs = [];

  ///
  @override
  Widget build(BuildContext context) {
    makeTab();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            //-------------------------//これを消すと「←」が出てくる（消さない）
            leading: const Icon(Icons.check_box_outline_blank, color: Colors.transparent),
            //-------------------------//これを消すと「←」が出てくる（消さない）

            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.blueAccent,
              tabs: tabs.map((TabInfo tab) => Tab(text: tab.label)).toList(),
            ),
          ),
        ),
        body: TabBarView(children: tabs.map((tab) => tab.widget).toList()),
      ),
    );
  }

  ///
  void makeTab() {
    tabs.clear();

    final years = <String>[];

    widget.selectedYearmonthList.forEach((element) {
      final exElement = element.split('-');
      if (!years.contains(exElement[0])) {
        years.add(exElement[0]);
      }
    });

    final yearlyCreditDetailMap = <String, List<CreditDetail>>{};

    widget.creditDetailList?.forEach((element) {
      yearlyCreditDetailMap[element.creditDate.split('-')[0]] = [];
    });

    widget.creditDetailList?.forEach((element) {
      yearlyCreditDetailMap[element.creditDate.split('-')[0]]?.add(element);
    });

    years
      ..sort((a, b) => -1 * a.compareTo(b))
      ..forEach(
        (element) {
          tabs.add(
            TabInfo(
              element,
              YearlyCreditCategoryListPage(
                isar: widget.isar,
                date: DateTime.parse('$element-01-01 00:00:00'),
                creditItemList: widget.creditItemList,
                creditDetailList: yearlyCreditDetailMap[element] ?? [],
              ),
            ),
          );
        },
      );
  }
}

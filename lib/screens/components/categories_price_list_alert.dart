import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../collections/config.dart';
import '../../collections/credit_detail.dart';
import '../../collections/credit_item.dart';
import '../../extensions/extensions.dart';
import 'pages/categories_price_list_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class CategoriesPriceListAlert extends StatefulWidget {
  const CategoriesPriceListAlert(
      {super.key, required this.isar, required this.date, required this.creditItemList, required this.creditDetailList, required this.configList});

  final Isar isar;
  final DateTime date;
  final List<CreditItem>? creditItemList;
  final List<CreditDetail>? creditDetailList;
  final List<Config>? configList;

  @override
  State<CategoriesPriceListAlert> createState() => _CategoriesPriceListAlertState();
}

class _CategoriesPriceListAlertState extends State<CategoriesPriceListAlert> {
  final List<TabInfo> _tabs = [];

  ///
  @override
  Widget build(BuildContext context) {
    _makeTab();

    return DefaultTabController(
      length: _tabs.length,
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
              tabs: _tabs.map((TabInfo tab) => Tab(text: tab.label)).toList(),
            ),
          ),
        ),
        body: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
      ),
    );
  }

  ///
  void _makeTab() {
    final settingConfigMap = <String, String>{};
    widget.configList?.forEach((element) => settingConfigMap[element.configKey] = element.configValue);

    final ymList = <String>[];
    if (settingConfigMap['start_yearmonth'] != null && settingConfigMap['start_yearmonth'] != '') {
      final exYearmonth = settingConfigMap['start_yearmonth']!.split('-');
      if (exYearmonth.length > 1) {
        if (exYearmonth[0] != '' && exYearmonth[1] != '') {
          final firstDate = DateTime(exYearmonth[0].toInt(), exYearmonth[1].toInt());
          final diff = DateTime.now().difference(firstDate).inDays;
          final yearmonthList = <String>[];
          for (var i = 0; i <= diff; i++) {
            final yearmonth = firstDate.add(Duration(days: i)).yyyymm;
            if (!yearmonthList.contains(yearmonth)) {
              ymList.add(yearmonth);
            }
            yearmonthList.add(yearmonth);
          }
        }
      }
    }

    ymList
      ..sort((a, b) => -1 * a.compareTo(b))
      ..forEach(
        (element) {
          _tabs.add(
            TabInfo(
              element,
              CategoriesPriceListPage(
                isar: widget.isar,
                date: DateTime.parse('$element-01 00:00:00'),
                creditItemList: widget.creditItemList,
                creditDetailList: widget.creditDetailList,
              ),
            ),
          );
        },
      );
  }
}

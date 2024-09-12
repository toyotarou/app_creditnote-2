import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

class CategoriesPriceListAlert extends HookConsumerWidget {
  CategoriesPriceListAlert(
      {super.key,
      required this.isar,
      required this.date,
      required this.creditItemList,
      required this.creditDetailList,
      required this.configList,
      required this.index});

  final Isar isar;
  final DateTime date;
  final List<CreditItem>? creditItemList;
  final List<CreditDetail>? creditDetailList;
  final List<Config>? configList;

  final int index;

  final List<TabInfo> tabs = <TabInfo>[];

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    makeTab();

    // 最初に開くタブを指定する
    final TabController tabController = useTabController(initialLength: tabs.length);
    if (index > 0) {
      tabController.index = index;
    }
    // 最初に開くタブを指定する

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            //-------------------------//これを消すと「←」が出てくる（消さない）
            leading: const Icon(Icons.check_box_outline_blank,
                color: Colors.transparent),
            //-------------------------//これを消すと「←」が出てくる（消さない）

            bottom: TabBar(
              //================================//
              controller: tabController,
              //================================//

              isScrollable: true,
              indicatorColor: Colors.blueAccent,
              tabs: tabs.map((TabInfo tab) => Tab(text: tab.label)).toList(),
            ),
          ),
        ),
        body: TabBarView(
          //================================//
          controller: tabController,
          //================================//

          children: tabs.map((TabInfo tab) => tab.widget).toList(),
        ),
      ),
    );
  }

  ///
  void makeTab() {
    tabs.clear();

    final Map<String, String> settingConfigMap = <String, String>{};
    configList?.forEach(
        (Config element) => settingConfigMap[element.configKey] = element.configValue);

    final List<String> ymList = <String>[];
    if (settingConfigMap['start_yearmonth'] != null &&
        settingConfigMap['start_yearmonth'] != '') {
      final List<String> exYearmonth = settingConfigMap['start_yearmonth']!.split('-');
      if (exYearmonth.length > 1) {
        if (exYearmonth[0] != '' && exYearmonth[1] != '') {
          final DateTime firstDate =
              DateTime(exYearmonth[0].toInt(), exYearmonth[1].toInt());
          final int diff = DateTime.now().difference(firstDate).inDays;
          final List<String> yearmonthList = <String>[];
          for (int i = 0; i <= diff; i++) {
            final String yearmonth = firstDate.add(Duration(days: i)).yyyymm;
            if (!yearmonthList.contains(yearmonth)) {
              ymList.add(yearmonth);
            }
            yearmonthList.add(yearmonth);
          }
        }
      }
    }

    ymList
      ..sort((String a, String b) => -1 * a.compareTo(b))
      ..forEach(
        (String element) {
          tabs.add(
            TabInfo(
              element,
              CategoriesPriceListPage(
                isar: isar,
                date: DateTime.parse('$element-01 00:00:00'),
                creditItemList: creditItemList,
                creditDetailList: creditDetailList,
              ),
            ),
          );
        },
      );
  }
}

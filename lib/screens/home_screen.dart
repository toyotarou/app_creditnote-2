import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../collections/config.dart';
import '../extensions/extensions.dart';
import 'components/config_setting_alert.dart';
import 'components/parts/credit_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.isar});

  final Isar isar;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Config>? configList = [];

  Map<String, String> settingConfigMap = {};

  ///
  void _init() {
    makeSettingConfigMap();
  }

  ///
  @override
  Widget build(BuildContext context) {
    Future(_init);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          if (settingConfigMap['start_yearmonth'] != null) ...[
            Expanded(child: _displayYearmonthList()),
          ],
        ],
      ),
      endDrawer: _dispDrawer(),
    );
  }

  ///
  Widget _dispDrawer() {
    return Drawer(
      backgroundColor: Colors.blueGrey.withOpacity(0.2),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  CreditDialog(
                    context: context,
                    widget: ConfigSettingAlert(isar: widget.isar),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                        margin: const EdgeInsets.all(5),
                        child: const Text('設定'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> makeSettingConfigMap() async {
    final configsCollection = widget.isar.configs;

    final getConfigs = await configsCollection.where().findAll();

    setState(() {
      configList = getConfigs;

      getConfigs.forEach((element) => settingConfigMap[element.configKey] = element.configValue);
    });
  }

  ///
  Widget _displayYearmonthList() {
    final list = <Widget>[];

    if (settingConfigMap['start_yearmonth'] != null && settingConfigMap['start_yearmonth'] != '') {
      final exYearmonth = settingConfigMap['start_yearmonth']!.split('-');

      final firstDate = DateTime(exYearmonth[0].toInt(), exYearmonth[1].toInt());

      final diff = DateTime.now().difference(firstDate).inDays;

      final yearmonthList = <String>[];

      for (var i = 0; i <= diff; i++) {
        final yearmonth = firstDate.add(Duration(days: i)).yyyymm;

        if (!yearmonthList.contains(yearmonth)) {
          list.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(yearmonth),
              Container(),
            ],
          ));
        }

        yearmonthList.add(yearmonth);
      }
    }

    return SingleChildScrollView(child: Column(children: list));
  }
}

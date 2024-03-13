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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Credit List'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
            icon: Icon(Icons.settings, color: Colors.white.withOpacity(0.6), size: 20),
          )
        ],
      ),
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

      if (exYearmonth.length > 1) {
        if (exYearmonth[0] != '' && exYearmonth[1] != '') {
          final firstDate = DateTime(exYearmonth[0].toInt(), exYearmonth[1].toInt());

          final diff = DateTime.now().difference(firstDate).inDays;

          final yearmonthList = <String>[];

          for (var i = 0; i <= diff; i++) {
            final yearmonth = firstDate.add(Duration(days: i)).yyyymm;

            if (!yearmonthList.contains(yearmonth)) {
              list.add(Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 70,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(yearmonth),
                                  const SizedBox(height: 5),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: Icon(Icons.input, color: Colors.greenAccent.withOpacity(0.4)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        )),
                    Expanded(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: context.screenSize.height / 15),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.1)),
                          child: const Text('aaa'),
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      alignment: Alignment.topRight,
                      child: const Text('9999,9999'),
                    ),
                  ],
                ),
              ));
            }

            yearmonthList.add(yearmonth);
          }
        }
      }
    }

    return SingleChildScrollView(
        child: DefaultTextStyle(style: const TextStyle(fontSize: 12), child: Column(children: list)));
  }
}

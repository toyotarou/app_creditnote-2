import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/config.dart';
import '../../extensions/extensions.dart';
import '../../state/config_start_yearmonth/config_start_yearmonth_notifier.dart';
import 'parts/error_dialog.dart';

class ConfigSettingAlert extends ConsumerStatefulWidget {
  const ConfigSettingAlert({super.key, required this.isar});

  final Isar isar;

  ///
  @override
  ConsumerState<ConfigSettingAlert> createState() => _ConfigSettingAlertState();
}

class _ConfigSettingAlertState extends ConsumerState<ConfigSettingAlert> {
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
              const Text('設定'),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              _displayStartYearmonthSettingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayStartYearmonthSettingWidget() {
    //==============================//
    var configSelectedyear = -1;
    var configSelectedmonth = -1;

    if (settingConfigMap['start_yearmonth'] != null && settingConfigMap['start_yearmonth'] != '') {
      final exYearmonth = settingConfigMap['start_yearmonth']!.split('-');

      if (exYearmonth.length > 1) {
        if (exYearmonth[0] != '' && exYearmonth[1] != '') {
          configSelectedyear = exYearmonth[0].toInt();
          configSelectedmonth = exYearmonth[1].toInt() - 1;
        }
      }
    }
    //==============================//

    final configStartYearmonthState = ref.watch(configStartYearmonthProvider);

    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: context.screenSize.width),
          const Text('開始する年月'),
          const SizedBox(height: 10),
          Wrap(
            children: configStartYearmonthState.startYears.map((e) {
              return GestureDetector(
                onTap: () {
                  (settingConfigMap['start_yearmonth'] != null)
                      ? updateConfig(key: 'start_yearmonth', value: '', closeFlag: false)
                      : inputConfig(key: 'start_yearmonth', value: '', closeFlag: false);

                  ref.read(configStartYearmonthProvider.notifier).setSelectedYear(year: e);
                },
                child: Container(
                  width: context.screenSize.width / 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    color: (configStartYearmonthState.selectedStartYear == e || configSelectedyear == e)
                        ? Colors.yellowAccent.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Text(e.toString()),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Wrap(
            children: configStartYearmonthState.startMonths.map((e) {
              return GestureDetector(
                onTap: () {
                  (settingConfigMap['start_yearmonth'] != null)
                      ? updateConfig(key: 'start_yearmonth', value: '', closeFlag: false)
                      : inputConfig(key: 'start_yearmonth', value: '', closeFlag: false);

                  ref.read(configStartYearmonthProvider.notifier).setSelectedMonth(month: e);
                },
                child: Container(
                  width: context.screenSize.width / 10,
                  margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    color: (configStartYearmonthState.selectedStartMonth == e || configSelectedmonth == e)
                        ? Colors.yellowAccent.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Text((e + 1).toString().padLeft(2, '0')),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                GestureDetector(
                  onTap: () {
                    final year = configStartYearmonthState.selectedStartYear;
                    final month = configStartYearmonthState.selectedStartMonth;

                    final val = '$year-${(month + 1).toString().padLeft(2, '0')}';

                    if (year == -1 || month == -1) {
                      Future.delayed(
                        Duration.zero,
                        () => error_dialog(context: context, title: '登録できません。', content: '値を正しく入力してください。'),
                      );

                      return;
                    }

                    (settingConfigMap['start_yearmonth'] != null)
                        ? updateConfig(key: 'start_yearmonth', value: val, closeFlag: true)
                        : inputConfig(key: 'start_yearmonth', value: val, closeFlag: true);
                  },
                  child: Text(
                    '設定する',
                    style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  Future<void> inputConfig({required String key, required String value, required bool closeFlag}) async {
    final config = Config()
      ..configKey = key
      ..configValue = value;

    await widget.isar.writeTxn(() async => widget.isar.configs.put(config)).then((value) {
      if (closeFlag) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
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
  Future<void> updateConfig({required String key, required String value, required bool closeFlag}) async {
    final configsCollection = widget.isar.configs;

    await widget.isar.writeTxn(() async {
      final config = await configsCollection.filter().configKeyEqualTo(key).findFirst();
      config!.configValue = value;
      await configsCollection.put(config);
    }).then((value) {
      if (closeFlag) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
  }
}

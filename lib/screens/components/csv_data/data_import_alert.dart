import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../../collections/config.dart';
import '../../../collections/credit.dart';
import '../../../collections/credit_detail.dart';
import '../../../collections/credit_item.dart';
import '../../../collections/subscription_item.dart';
import '../../../extensions/extensions.dart';
import '../../../repository/configs_repository.dart';
import '../../../repository/credit_details_repository.dart';
import '../../../repository/credit_items_repository.dart';
import '../../../repository/credits_repository.dart';
import '../../../repository/subscription_items_repository.dart';
import '../parts/error_dialog.dart';

class DataImportAlert extends StatefulWidget {
  const DataImportAlert({super.key, required this.isar});

  final Isar isar;

  @override
  State<DataImportAlert> createState() => _DataImportAlertState();
}

class _DataImportAlertState extends State<DataImportAlert> {
  String fileName = '';

  String csvName = '';

  List<String> csvContentsList = <String>[];

  List<dynamic> importDataList = <dynamic>[];
  int importDataListLength = 0;

  ///
  @override
  void initState() {
    super.initState();

    fileName = '';

    csvName = '';

    csvContentsList = <String>[];

    importDataList = <dynamic>[];
  }

  ///
  Future<void> _pickAndLoadCsvFile() async {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: <String>['csv']);

    if (result != null) {
      ///
      fileName = result.files.single.name;

      csvName = fileName.split('_')[0];

      ///
      final File file = File(result.files.single.path!);
      final String csvString = await file.readAsString();
      final List<String> exCsvString = csvString.split('\n');

      if (exCsvString[0] != 'export_csv_from_credit_note') {
        setState(() {
          fileName = '';

          csvName = '';

          csvContentsList = <String>[];

          importDataList = <dynamic>[];
        });

        getErrorDialog(title: '出力できません。', content: '出力するデータを正しく選択してください。');

        return;
      }

      setState(() {
        csvContentsList = exCsvString;
      });
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
              Container(width: context.screenSize.width),
              const SizedBox(height: 20),
              const Text('データインポート'),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _pickAndLoadCsvFile,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent.withOpacity(0.2)),
                      child: const Text('CSV選択'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: registData,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent.withOpacity(0.2)),
                      child: const Text('登録'),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Text(fileName),
              if (csvContentsList.isNotEmpty) ...<Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    Text(
                      '${csvContentsList.length} records.',
                      style: const TextStyle(color: Colors.yellowAccent),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 20),
              Expanded(child: displayCsvContents()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void getErrorDialog({required String title, required String content}) {
    // ignore: always_specify_types
    Future.delayed(
      Duration.zero,
      () {
        if (mounted) {
          return error_dialog(context: context, title: title, content: content);
        }
      },
    );
  }

  ///
  Widget displayCsvContents() {
    switch (csvName) {
      case 'config':
        importDataList = <Config>[];
      case 'credit':
        importDataList = <Credit>[];
      case 'creditDetail':
        importDataList = <CreditDetail>[];
      case 'creditItem':
        importDataList = <CreditItem>[];
      case 'subscriptionItem':
        importDataList = <SubscriptionItem>[];
    }

    final List<Widget> widgetList = <Widget>[];

    for (int i = 1; i < csvContentsList.length; i++) {
      final List<String> exLine = csvContentsList[i].split(',');

      final List<Widget> widgetList2 = <Widget>[];

      for (int j = 1; j < exLine.length; j++) {
        widgetList2.add(
          Container(
            width: context.screenSize.width / 3,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child:
                Text(exLine[j], maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        );
      }

      widgetList.add(Row(children: widgetList2));

      switch (csvName) {
        case 'config':
          importDataList.add(Config()
            ..configKey = exLine[1].trim()
            ..configValue = exLine[2].trim());

        case 'credit':
          importDataList.add(Credit()
            ..date = exLine[1].trim()
            ..name = exLine[2].trim()
            ..price = exLine[3].trim().toInt());

        case 'creditDetail':
          importDataList.add(CreditDetail()
            ..yearmonth = exLine[1].trim()
            ..creditDate = exLine[2].trim()
            ..creditPrice = exLine[3].trim()
            ..creditDetailDate = exLine[4].trim()
            ..creditDetailItem = exLine[5].trim()
            ..creditDetailDescription = exLine[6].trim()
            ..creditDetailPrice = exLine[7].trim().toInt());

        case 'creditItem':
          importDataList.add(CreditItem()
            ..name = exLine[1].trim()
            ..order = exLine[2].trim().toInt()
            ..color = exLine[3].trim());

        case 'subscriptionItem':
          importDataList.add(SubscriptionItem()..name = exLine[1].trim());
      }
    }

    setState(() {
      importDataListLength = importDataList.length;
    });

    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgetList,
        ),
      ),
    );
  }

  ///
  Future<void> registData() async {
    if ((csvContentsList.length - 1) != importDataList.length) {
      getErrorDialog(title: '登録できません。', content: '登録するデータが正しく選択されていません。');

      return;
    }

    switch (csvName) {
      case 'config':
        await ConfigsRepository()
            .inputConfigList(
                isar: widget.isar, configList: importDataList as List<Config>)
            // ignore: always_specify_types
            .then((value) {
          if (mounted) {
            Navigator.pop(context);
          }
        });

      case 'credit':
        await CreditsRepository()
            .inputCreditList(
                isar: widget.isar, creditList: importDataList as List<Credit>)
            // ignore: always_specify_types
            .then((value) {
          if (mounted) {
            Navigator.pop(context);
          }
        });

      case 'creditDetail':
        await CreditDetailsRepository()
            .inputCreditDetailList(
                isar: widget.isar,
                creditDetailList: importDataList as List<CreditDetail>)
            // ignore: always_specify_types
            .then((value) {
          if (mounted) {
            Navigator.pop(context);
          }
        });

      case 'creditItem':
        await CreditItemsRepository()
            .inputCreditItemList(
                isar: widget.isar,
                creditItemList: importDataList as List<CreditItem>)
            // ignore: always_specify_types
            .then((value) {
          if (mounted) {
            Navigator.pop(context);
          }
        });

      case 'subscriptionItem':
        await SubscriptionItemsRepository()
            .inputSubscriptionItemList(
                isar: widget.isar,
                subscriptionItemList: importDataList as List<SubscriptionItem>)
            // ignore: always_specify_types
            .then((value) {
          if (mounted) {
            Navigator.pop(context);
          }
        });
    }
  }
}

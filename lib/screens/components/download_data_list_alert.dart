import 'dart:io';

import 'package:charset_converter/charset_converter.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../collections/credit.dart';
import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';
import '../../state/data_download/data_download_notifier.dart';
import 'parts/credit_dialog.dart';
import 'parts/error_dialog.dart';
import 'parts/year_month_select_dialog.dart';

class DownloadDataListAlert extends ConsumerStatefulWidget {
  const DownloadDataListAlert({
    super.key,
    required this.isar,
    required this.selectedYearmonthList,
    required this.creditList,
    required this.creditDetailList,
    required this.allSameNumFlag,
  });

  final Isar isar;
  final List<String> selectedYearmonthList;
  final List<Credit> creditList;
  final List<CreditDetail> creditDetailList;
  final bool allSameNumFlag;

  ///
  @override
  ConsumerState<DownloadDataListAlert> createState() => _DownloadDataListAlertState();
}

class _DownloadDataListAlertState extends ConsumerState<DownloadDataListAlert> {
  List<String> outputValuesList = [];

  String externalStoragePublicDirectoryPath = '';

  ///
  @override
  void initState() {
    super.initState();

    getPublicDirectoryPath();
  }

  ///
  Future<void> getPublicDirectoryPath() async {
    final path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    setState(() {
      externalStoragePublicDirectoryPath = path;
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    final dataDownloadState = ref.watch(dataDownloadProvider);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('ダウンロードデータ選択'), Container()],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Row(
                children: [
                  SizedBox(
                    width: context.screenSize.width * 0.3,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _showYearMonthSelectDialog(pos: 'start');
                          },
                          icon: Icon(Icons.calendar_month, color: Colors.greenAccent.withOpacity(0.6)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [const Text('Start'), Text(dataDownloadState.startYearMonth)],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text('〜'),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _showYearMonthSelectDialog(pos: 'end');
                        },
                        icon: Icon(Icons.calendar_month, color: Colors.greenAccent.withOpacity(0.6)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [const Text('End'), Text(dataDownloadState.endYearMonth)],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  TextButton(
                    onPressed: outputCsv,
                    child: const Text('CSVを出力する'),
                  ),
                ],
              ),
              Expanded(child: _displayDownloadData()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void _showYearMonthSelectDialog({required String pos}) {
    CreditDialog(
      context: context,
      paddingTop: 100,
      paddingBottom: 100,
      paddingLeft: 20,
      paddingRight: 20,
      clearBarrierColor: true,
      widget: YearMonthSelectDialog(
        pos: pos,
        selectedYearmonthList: widget.selectedYearmonthList,
      ),
    );
  }

  ///
  Widget _displayDownloadData() {
    final list = <Widget>[];

    final dataDownloadState = ref.watch(dataDownloadProvider);

    if (dataDownloadState.startYearMonth == '' || dataDownloadState.endYearMonth == '') {
      return Container();
    }

    if (widget.allSameNumFlag == false) {
      list.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('クレジット詳細のレコードが存在しない年月はスキップしています。', style: TextStyle(color: Colors.yellowAccent)),
        ),
      );
    }

    //=====================//
    final yearMonthList = <String>[];

    final dateDiff = DateTime.parse('${dataDownloadState.endYearMonth}-01 00:00:00')
        .difference(DateTime.parse('${dataDownloadState.startYearMonth}-01 '
            '00:00:00'))
        .inDays;

    for (var i = 0; i <= dateDiff; i++) {
      final day = DateTime.parse('${dataDownloadState.startYearMonth}-01 00:00:00').add(Duration(days: i));

      if (!yearMonthList.contains(day.yyyymm)) {
        yearMonthList.add(day.yyyymm);
      }
    }

    //=====================//

    outputValuesList = [];

    yearMonthList.forEach((element) {
      widget.creditDetailList.where((element2) => element2.yearmonth == element).forEach((element3) {
        list.add(Row(
          children: [
            getDataCell(data: element3.yearmonth, width: 100, alignment: Alignment.topLeft),
            getDataCell(data: element3.creditDate, width: 100, alignment: Alignment.topLeft),
            getDataCell(data: element3.creditPrice, width: 100, alignment: Alignment.topRight),
            getDataCell(data: getCreditName(date: element3.creditDate, price: element3.creditPrice), width: 100, alignment: Alignment.topLeft),
            getDataCell(data: element3.creditDetailDate, width: 100, alignment: Alignment.topLeft),
            getDataCell(data: element3.creditDetailItem, width: 120, alignment: Alignment.topLeft),
            getDataCell(data: element3.creditDetailPrice.toString().toCurrency(), width: 100, alignment: Alignment.topRight),
            getDataCell(data: element3.creditDetailDescription, width: 300, alignment: Alignment.topLeft),
          ],
        ));

        outputValuesList.add([
          element3.yearmonth,
          element3.creditDate,
          element3.creditPrice,
          getCreditName(date: element3.creditDate, price: element3.creditPrice),
          element3.creditDetailDate,
          element3.creditDetailItem,
          element3.creditDetailPrice.toString(),
          element3.creditDetailDescription,
        ].join(','));
      });
    });

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
      ),
    );
  }

  ///
  Widget getDataCell({required String data, required double width, required Alignment alignment}) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(2),
      alignment: alignment,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2), width: 2))),
      child: Text(data),
    );
  }

  ///
  String getCreditName({required String date, required String price}) {
    var name = '';
    widget.creditList
        .where((element) => element.date == date)
        .where((element) => element.price.toString() == price)
        .forEach((element) => name = element.name);
    return name;
  }

  ///
  Future<void> outputCsv() async {
    if (outputValuesList.isEmpty) {
      getErrorDialog(title: '出力できません。', content: '出力するデータを正しく選択してください。');

      return;
    }

    final now = DateTime.now();
    final timeFormat = DateFormat('HHmmss');
    final currentTime = timeFormat.format(now);

    final year = now.year.toString();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');

    final dateStr = 'credit_$year$month$day$currentTime';
    final sendFileName = '$dateStr.csv';

    final exFilePath = '$externalStoragePublicDirectoryPath/$sendFileName';
    final textFilePath = File(exFilePath);

    final contents = outputValuesList.join('\n');

    final encoded = await CharsetConverter.encode('Shift_JIS', contents);
    await textFilePath.writeAsBytes(encoded);

    getErrorDialog(title: '出力しました。', content: 'ダウンロードフォルダにCSVを作成しました。');
  }

  ///
  void getErrorDialog({required String title, required String content}) {
    Future.delayed(
      Duration.zero,
      () => error_dialog(context: context, title: title, content: content),
    );
  }
}

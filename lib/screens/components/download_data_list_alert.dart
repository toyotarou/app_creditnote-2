import 'dart:io';
import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../collections/credit.dart';
import '../../collections/credit_detail.dart';
import '../../collections/credit_item.dart';
import '../../enums/data_download_data_type.dart';
import '../../extensions/extensions.dart';
import '../../state/data_download/data_download_notifier.dart';
import '../../state/data_download/data_download_response_state.dart';
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
    required this.creditItemList,
  });

  final Isar isar;
  final List<String> selectedYearmonthList;
  final List<Credit> creditList;
  final List<CreditDetail> creditDetailList;
  final bool allSameNumFlag;
  final List<CreditItem> creditItemList;

  ///
  @override
  ConsumerState<DownloadDataListAlert> createState() => _DownloadDataListAlertState();
}

class _DownloadDataListAlertState extends ConsumerState<DownloadDataListAlert> {
  List<String> outputValuesList = <String>[];

  String externalStoragePublicDirectoryPath = '';

  ///
  @override
  void initState() {
    super.initState();

    getPublicDirectoryPath();
  }

  ///
  Future<void> getPublicDirectoryPath() async {
    final String path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    setState(() {
      externalStoragePublicDirectoryPath = path;
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    final DataDownloadResponseState dataDownloadState = ref.watch(dataDownloadProvider);

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
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[const Text('ダウンロードデータ選択'), Container()],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              ElevatedButton(
                onPressed: () {
                  ref.read(dataDownloadProvider.notifier).setDataType(dataType: DateDownloadDataType.creditItem);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: (dataDownloadState.dataType == DateDownloadDataType.creditItem)
                        ? Colors.yellowAccent.withOpacity(0.3)
                        : Colors.pinkAccent.withOpacity(0.2)),
                child: const Text('credit item'),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.4))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: context.screenSize.width * 0.3,
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  _showYearMonthSelectDialog(pos: 'start');
                                },
                                icon: Icon(Icons.calendar_month, color: Colors.greenAccent.withOpacity(0.6)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[const Text('Start'), Text(dataDownloadState.startYearMonth)],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text('〜'),
                        const SizedBox(width: 20),
                        Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                _showYearMonthSelectDialog(pos: 'end');
                              },
                              icon: Icon(Icons.calendar_month, color: Colors.greenAccent.withOpacity(0.6)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[const Text('End'), Text(dataDownloadState.endYearMonth)],
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(dataDownloadProvider.notifier).setDataType(dataType: DateDownloadDataType.credit);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: (dataDownloadState.dataType == DateDownloadDataType.credit)
                              ? Colors.yellowAccent.withOpacity(0.3)
                              : Colors.pinkAccent.withOpacity(0.2)),
                      child: const Text('credit'),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
    final List<Widget> list = <Widget>[];

    final DataDownloadResponseState dataDownloadState = ref.watch(dataDownloadProvider);

    if (dataDownloadState.dataType != null) {
      switch (dataDownloadState.dataType!) {
        case DateDownloadDataType.none:
          break;

        case DateDownloadDataType.credit:
          outputValuesList = <String>[];

          //=====================//
          final List<String> yearMonthList = <String>[];

          final int dateDiff = DateTime.parse('${dataDownloadState.endYearMonth}-01 00:00:00')
              .difference(DateTime.parse('${dataDownloadState.startYearMonth}-01 '
                  '00:00:00'))
              .inDays;

          for (int i = 0; i <= dateDiff; i++) {
            final DateTime day = DateTime.parse('${dataDownloadState.startYearMonth}-01 00:00:00').add(Duration(days: i));

            if (!yearMonthList.contains(day.yyyymm)) {
              yearMonthList.add(day.yyyymm);
            }
          }

          //=====================//

          if (dataDownloadState.startYearMonth == '' || dataDownloadState.endYearMonth == '') {
            return Container();
          }

          final DateTime startDateTime = DateTime.parse('${dataDownloadState.startYearMonth}-01 00:00:00');
          final DateTime endDateTime = DateTime.parse('${dataDownloadState.endYearMonth}-01 00:00:00');

          if (endDateTime.isBefore(startDateTime)) {
            // ignore: always_specify_types
            Future.delayed(
              Duration.zero,
              () => error_dialog(context: context, title: '検索できません。', content: '開始年月、終了年月を正しく入力してください。'),
            );

            return Container();
          }

          if (!widget.allSameNumFlag) {
            list.add(
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: const Text('クレジット詳細のレコードが存在しない年月はスキップしています。', style: TextStyle(color: Colors.yellowAccent)),
              ),
            );
          }

          for (final String element in yearMonthList) {
            widget.creditDetailList.where((CreditDetail element2) => element2.yearmonth == element).forEach((CreditDetail element3) {
              list.add(Row(
                children: <Widget>[
                  getDataCell(data: element3.yearmonth, width: 100, alignment: Alignment.topLeft),
                  getDataCell(data: element3.creditDate, width: 100, alignment: Alignment.topLeft),
                  getDataCell(data: element3.creditPrice, width: 100, alignment: Alignment.topRight),
                  getDataCell(
                      data: getCreditName(date: element3.creditDate, price: element3.creditPrice),
                      width: 100,
                      alignment: Alignment.topLeft),
                  getDataCell(data: element3.creditDetailDate, width: 100, alignment: Alignment.topLeft),
                  getDataCell(data: element3.creditDetailItem, width: 120, alignment: Alignment.topLeft),
                  getDataCell(
                      data: element3.creditDetailPrice.toString().toCurrency(),
                      width: 100,
                      alignment: Alignment.topRight),
                  getDataCell(data: element3.creditDetailDescription, width: 300, alignment: Alignment.topLeft),
                ],
              ));

              outputValuesList.add(<String>[
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
          }


        case DateDownloadDataType.creditItem:
          outputValuesList = <String>[];

          for (final CreditItem element in widget.creditItemList) {
            list.add(Row(
              children: <Widget>[
                getDataCell(data: element.name, width: 100, alignment: Alignment.topLeft),
                getDataCell(data: element.order.toString(), width: 100, alignment: Alignment.topLeft),
                getDataCell(data: element.color, width: 100, alignment: Alignment.topLeft),
              ],
            ));

            outputValuesList.add(<String>[element.name, element.order.toString(), "'${element.color}"].join(','));
          }

      }
    }

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
    String name = '';
    widget.creditList
        .where((Credit element) => element.date == date)
        .where((Credit element) => element.price.toString() == price)
        .forEach((Credit element) => name = element.name);
    return name;
  }

  ///
  Future<void> outputCsv() async {
    if (outputValuesList.isEmpty) {
      getErrorDialog(title: '出力できません。', content: '出力するデータを正しく選択してください。');

      return;
    }

    final DateTime now = DateTime.now();
    final DateFormat timeFormat = DateFormat('HHmmss');
    final String currentTime = timeFormat.format(now);

    final String year = now.year.toString();
    final String month = now.month.toString().padLeft(2, '0');
    final String day = now.day.toString().padLeft(2, '0');

    final DataDownloadResponseState dataDownloadState = ref.watch(dataDownloadProvider);

    final String dateStr = '${dataDownloadState.dataType!.japanName}_$year$month$day$currentTime';
    final String sendFileName = '$dateStr.csv';

    final String exFilePath = '$externalStoragePublicDirectoryPath/$sendFileName';
    final File textFilePath = File(exFilePath);

    final String contents = outputValuesList.join('\n');

    final Uint8List encoded = await CharsetConverter.encode('Shift_JIS', contents);
    await textFilePath.writeAsBytes(encoded);

    getErrorDialog(title: '出力しました。', content: 'ダウンロードフォルダにCSVを作成しました。');
  }

  ///
  void getErrorDialog({required String title, required String content}) {
    // ignore: always_specify_types
    Future.delayed(
      Duration.zero,
      () => error_dialog(context: context, title: title, content: content),
    );
  }
}

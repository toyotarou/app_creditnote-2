import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit.dart';
import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';
import '../../state/data_download/data_download_notifier.dart';
import 'parts/credit_dialog.dart';
import 'parts/year_month_select_dialog.dart';

class DownloadDataListAlert extends ConsumerStatefulWidget {
  const DownloadDataListAlert(
      {super.key, required this.isar, required this.selectedYearmonthList, required this.creditList, required this.creditDetailList});

  final Isar isar;
  final List<String> selectedYearmonthList;
  final List<Credit> creditList;
  final List<CreditDetail> creditDetailList;

  ///
  @override
  ConsumerState<DownloadDataListAlert> createState() => _DownloadDataListAlertState();
}

class _DownloadDataListAlertState extends ConsumerState<DownloadDataListAlert> {
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

    yearMonthList.forEach((element) {
      list.add(Text(element));
    });

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(physics: const BouncingScrollPhysics(), child: Column(children: list)),
    );
  }

  ///
  Future<void> outputCsv() async {}
}

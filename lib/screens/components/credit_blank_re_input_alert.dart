import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit.dart';
import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';

class CreditBlankReInputAlert extends ConsumerStatefulWidget {
  const CreditBlankReInputAlert(
      {super.key, required this.isar, required this.date, required this.creditList, required this.creditBlankCreditDetailList});

  final Isar isar;
  final DateTime date;
  final List<Credit>? creditList;
  final List<CreditDetail> creditBlankCreditDetailList;

  @override
  ConsumerState<CreditBlankReInputAlert> createState() => _CreditBlankReInputAlertState();
}

class _CreditBlankReInputAlertState extends ConsumerState<CreditBlankReInputAlert> {
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
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [const Text('Credit Blank ReInput'), Text(widget.date.yyyymm)],
                  ),
                  // ElevatedButton(
                  //   onPressed: inputButtonClicked
                  //       ? null
                  //       : () {
                  //     ref.read(appParamProvider.notifier).setInputButtonClicked(flag: true);
                  //
                  //     _inputCredit();
                  //   },
                  //   style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.withOpacity(0.2)),
                  //   child: const Text('input'),
                  // ),

                  Container(),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),

              //
              //
              // if (widget.creditBlankCreditDetailList.isNotEmpty) ...[
              //   Row(
              //     children: [
              //       Expanded(
              //         child: Text(
              //           'クレジットカードに紐づいていない当月の詳細情報が存在します。',
              //           style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
              //         ),
              //       ),
              //       const SizedBox(width: 10),
              //       GestureDetector(
              //         onTap: () {},
              //         child: Icon(Icons.info_outline, color: Colors.greenAccent.withOpacity(0.6)),
              //       ),
              //     ],
              //   ),
              //   const SizedBox(height: 20),
              // ],
              // Expanded(child: _displayInputParts()),
            ],
          ),
        ),
      ),
    );
  }
}

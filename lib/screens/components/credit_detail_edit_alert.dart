import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';

class CreditDetailEditAlert extends StatefulWidget {
  const CreditDetailEditAlert({super.key, required this.isar, required this.creditDetail});

  final Isar isar;
  final CreditDetail creditDetail;

  @override
  State<CreditDetailEditAlert> createState() => _CreditDetailEditAlertState();
}

class _CreditDetailEditAlertState extends State<CreditDetailEditAlert> {
  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();

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
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Credit Detail Edit')],
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
              //         onTap: () {
              //           ref.read(appParamProvider.notifier).setInputButtonClicked(flag: false);
              //
              //           CreditDialog(
              //             context: context,
              //             widget: CreditBlankReInputAlert(
              //               isar: widget.isar,
              //               date: widget.date,
              //               creditList: widget.creditList,
              //               creditBlankCreditDetailList: widget.creditBlankCreditDetailList,
              //             ),
              //           );
              //         },
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit.dart';
import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';
import '../../model/credit_blank_input_value.dart';
import '../../state/app_params/app_params_notifier.dart';
import '../../state/credit_blank/credit_blank_notifier.dart';

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
  ///
  @override
  Widget build(BuildContext context) {
    final inputButtonClicked = ref.watch(appParamProvider.select((value) => value.inputButtonClicked));

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
                  ElevatedButton(
                    onPressed: inputButtonClicked
                        ? null
                        : () {
                            ref.read(appParamProvider.notifier).setInputButtonClicked(flag: true);

                            _inputCreditBlankReInput();
                          },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.withOpacity(0.2)),
                    child: const Text('input'),
                  ),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: _displayInputParts()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _inputCreditBlankReInput() async {}

  ///
  Widget _displayInputParts() {
    final list = <Widget>[];

    final creditBlankSettingMap = ref.watch(appParamProvider.select((value) => value.creditBlankSettingMap));

    for (var i = 0; i < widget.creditBlankCreditDetailList.length; i++) {
      list.add(DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 24, spreadRadius: 16, color: Colors.black.withOpacity(0.2))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Stack(
              children: [
                Positioned(
                  bottom: 5,
                  right: 15,
                  child: Text(
                    (i + 1).toString().padLeft(2, '0'),
                    style: TextStyle(fontSize: 60, color: Colors.grey.withOpacity(0.3)),
                  ),
                ),
                Container(
                  width: context.screenSize.width,
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
//                        color: (date != '' && name != '' && price != -1) ? Colors.orangeAccent.withOpacity(0.4) : Colors.white.withOpacity(0.2),

                        color: Colors.white.withOpacity(0.2),
                        width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.creditList!.isNotEmpty) ...[
                        Wrap(
                            children: widget.creditList!.map((e) {
                          return GestureDetector(
                            onTap: () {
                              ref.read(appParamProvider.notifier).setCreditBlankSettingMap(pos: i, creditName: e.name);

                              ref.read(creditBlankProvider.notifier).setSelectedCreditBlankInputValue(
                                    pos: i,
                                    value: CreditBlankInputValue(widget.creditBlankCreditDetailList[i].id, e.name),
                                  );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: CircleAvatar(
                                backgroundColor: (creditBlankSettingMap[i] == e.name) ? Colors.yellowAccent.withOpacity(0.3) : Colors.black,
                                child: Text(e.name, style: const TextStyle(fontSize: 8, color: Colors.white)),
                              ),
                            ),
                          );
                        }).toList()),
                        const SizedBox(height: 10),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.creditBlankCreditDetailList[i].creditDetailDate),
                          Text(widget.creditBlankCreditDetailList[i].creditDetailPrice.toString().toCurrency()),
                        ],
                      ),
                      Text(widget.creditBlankCreditDetailList[i].creditDetailItem),
                      Text(widget.creditBlankCreditDetailList[i].creditDetailDescription),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }

    return SingleChildScrollView(child: Column(children: list));
  }
}

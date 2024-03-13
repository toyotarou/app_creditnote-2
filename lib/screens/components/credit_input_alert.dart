import 'dart:ui';

import 'package:credit_note/state/credit_input/credit_input_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../extensions/extensions.dart';
import '../../state/app_params/app_params_notifier.dart';

class CreditInputAlert extends ConsumerStatefulWidget {
  const CreditInputAlert({super.key, required this.isar, required this.date});

  final Isar isar;
  final DateTime date;

  @override
  ConsumerState<CreditInputAlert> createState() => _CreditInputAlertState();
}

class _CreditInputAlertState extends ConsumerState<CreditInputAlert> {
  final List<TextEditingController> _creditNameTecs = [];
  final List<TextEditingController> _creditPriceTecs = [];

  ///
  @override
  void initState() {
    super.initState();

    _makeTecs();
  }

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
                    children: [
                      Text(widget.date.yyyymmdd),
                      const Text('Credit Input'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: inputButtonClicked
                        ? null
                        : () {
                            ref.read(appParamProvider.notifier).setInputButtonClicked(flag: true);

                            _inputCredit();
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
  void _makeTecs() {
    for (var i = 0; i < 10; i++) {
      _creditNameTecs.add(TextEditingController(text: ''));
      _creditPriceTecs.add(TextEditingController(text: ''));
    }
  }

  ///
  Widget _displayInputParts() {
    final list = <Widget>[];

    final creditInputState = ref.watch(creditInputProvider);

    for (var i = 0; i < 10; i++) {
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
                    border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _showDP(pos: i),
                            child: Icon(Icons.calendar_month, color: Colors.greenAccent.withOpacity(0.6)),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: context.screenSize.width / 6,
                            child: Text(creditInputState.creditDates[i], style: const TextStyle(fontSize: 10)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _creditNameTecs[i],
                              decoration: const InputDecoration(labelText: 'クレジット名'),
                              style: const TextStyle(fontSize: 13, color: Colors.white),
                              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                              onChanged: (value) {
                                if (value != '') {
                                  ref.read(creditInputProvider.notifier).setCreditName(pos: i, name: value);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _creditPriceTecs[i],
                              decoration: const InputDecoration(labelText: '金額'),
                              style: const TextStyle(fontSize: 13, color: Colors.white),
                              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                              onChanged: (value) {
                                if (value != '') {
                                  ref.read(creditInputProvider.notifier).setCreditPrice(pos: i, price: value.toInt());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
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

  ///
  Future<void> _showDP({required int pos}) async {
    final selectedDate = await showDatePicker(
      barrierColor: Colors.transparent,
      locale: const Locale('ja'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 360)),
    );

    if (selectedDate != null) {
      await ref.read(creditInputProvider.notifier).setCreditDate(pos: pos, date: selectedDate.yyyymmdd);
    }
  }

  ///
  Future<void> _inputCredit() async {}
}

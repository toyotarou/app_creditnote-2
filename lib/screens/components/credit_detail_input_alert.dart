import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../collections/credit_item.dart';
import '../../extensions/extensions.dart';
import '../../repository/credit_details_repository.dart';
import '../../state/app_params/app_params_notifier.dart';
import '../../state/credit_detail_input/credit_detail_input_notifier.dart';
import '../../utility/function.dart';
import 'parts/error_dialog.dart';

class CreditDetailInputAlert extends ConsumerStatefulWidget {
  const CreditDetailInputAlert({
    super.key,
    required this.isar,
    required this.creditDate,
    required this.creditPrice,
    required this.creditItemList,
    required this.creditDetailList,
  });

  final Isar isar;

  final DateTime creditDate;
  final int creditPrice;

  final List<CreditItem> creditItemList;

  final List<CreditDetail>? creditDetailList;

  ///
  @override
  ConsumerState<CreditDetailInputAlert> createState() => _CreditDetailInputAlertState();
}

class _CreditDetailInputAlertState extends ConsumerState<CreditDetailInputAlert> {
  final List<TextEditingController> _priceTecs = [];
  final List<TextEditingController> _descriptionTecs = [];

  int roopNum = 60;

  ///
  @override
  void initState() {
    super.initState();

    _makeTecs();
  }

  ///
  Future<void> _makeTecs() async {
    for (var i = 0; i < roopNum; i++) {
      _priceTecs.add(TextEditingController(text: ''));
      _descriptionTecs.add(TextEditingController(text: ''));
    }

    if (widget.creditDetailList!.isNotEmpty) {
      await Future(() => ref.read(creditDetailInputProvider.notifier).setUpdateCreditDetail(updateCreditDetailList: widget.creditDetailList!));

      for (var i = 0; i < widget.creditDetailList!.length; i++) {
        _priceTecs[i].text = widget.creditDetailList![i].creditDetailPrice.toString();
        _descriptionTecs[i].text = widget.creditDetailList![i].creditDetailDescription;
      }
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    final inputButtonClicked = ref.watch(appParamProvider.select((value) => value.inputButtonClicked));

    final creditDetailState = ref.watch(creditDetailInputProvider);

    Future(() => ref.read(creditDetailInputProvider.notifier).setBaseDiff(baseDiff: widget.creditPrice.toString()));

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
                    children: [
                      const Text('Credit Detail Input'),
                      Text(widget.creditDate.yyyymmdd),
                      Text(widget.creditPrice.toString().toCurrency()),
                      Text(
                        (creditDetailState.diff != 0)
                            ? creditDetailState.diff.toString().toCurrency()
                            : (creditDetailState.baseDiff == '')
                                ? ''
                                : creditDetailState.baseDiff.toCurrency(),
                        style: TextStyle(color: (creditDetailState.diff == 0) ? Colors.yellowAccent : Colors.white),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: inputButtonClicked
                        ? null
                        : () {
                            ref.read(appParamProvider.notifier).setInputButtonClicked(flag: true);

                            _inputCreditDetail();
                          },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.withOpacity(0.2)),
                    child: const Text('input'),
                  ),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              Expanded(child: SingleChildScrollView(child: _displayInputParts())),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayInputParts() {
    final list = <Widget>[];

    final creditDetailInputState = ref.watch(creditDetailInputProvider);

    final itemList = <CreditItem>[CreditItem()..name = ''];
    widget.creditItemList.forEach(itemList.add);

    for (var i = 0; i < roopNum; i++) {
      final date = creditDetailInputState.creditDetailInputDates[i];
      final item = creditDetailInputState.creditDetailInputItems[i];
      final price = creditDetailInputState.creditDetailInputPrices[i];
      final description = creditDetailInputState.creditDetailInputDescriptions[i];

      var blankAlert = false;
      if (price != 0) {
        [date, item, description].forEach((element) {
          if (element == '') {
            blankAlert = true;
          }
        });
      }

      list.add(
        Container(
          width: context.screenSize.width * 0.35,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: (date != '' && item != '' && price != 0 && description != '')
                    ? Colors.orangeAccent.withOpacity(0.4)
                    : Colors.white.withOpacity(0.2),
                width: 2),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 5,
                child: Text(
                  (i + 1).toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 60,
                    color: (date != '' && item != '' && price != 0 && description != '')
                        ? Colors.orangeAccent.withOpacity(0.2)
                        : Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
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
                            child: Text(creditDetailInputState.creditDetailInputDates[i], style: const TextStyle(fontSize: 10)),
                          ),
                        ],
                      ),
                      GestureDetector(onTap: () => _clearOneBox(pos: i), child: const Icon(Icons.close, color: Colors.redAccent)),
                    ],
                  ),
                  DropdownButton(
                    isExpanded: true,
                    dropdownColor: Colors.pinkAccent.withOpacity(0.1),
                    iconEnabledColor: Colors.white,
                    items: itemList.map((e) {
                      return DropdownMenuItem(
                        value: e.name,
                        child: Text(e.name, style: const TextStyle(fontSize: 12)),
                      );
                    }).toList(),
                    value: creditDetailInputState.creditDetailInputItems[i],
                    onChanged: (value) => ref.read(creditDetailInputProvider.notifier).setCreditDetailItem(pos: i, item: value!),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _priceTecs[i],
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      hintText: '金額(10桁以内)',
                      filled: true,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                    ),
                    style: const TextStyle(fontSize: 12),
                    onChanged: (value) {
                      if (value != '') {
                        ref.read(creditDetailInputProvider.notifier).setCreditDetailPrice(pos: i, price: value.toInt());
                      } else {
                        ref.read(creditDetailInputProvider.notifier).setCreditDetailPrice(pos: i, price: creditDetailInputState.baseDiff.toInt());
                      }
                    },
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descriptionTecs[i],
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      hintText: '詳細(30文字以内)',
                      filled: true,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                    ),
                    style: const TextStyle(fontSize: 12),
                    onChanged: (value) => ref.read(creditDetailInputProvider.notifier).setCreditDetailDescription(pos: i, description: value),
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  if (blankAlert) ...[
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Container(), const Icon(Icons.ac_unit, size: 16, color: Colors.yellowAccent)],
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Wrap(children: list);
  }

  ///
  Future<void> _showDP({required int pos}) async {
    final selectedDate = await showDatePicker(
      barrierColor: Colors.transparent,
      locale: const Locale('ja'),
      context: context,
      initialDate: DateTime(widget.creditDate.year, widget.creditDate.month),
      firstDate: DateTime(widget.creditDate.year, widget.creditDate.month - 3),
      lastDate: DateTime(widget.creditDate.year, widget.creditDate.month + 1, 0),
    );

    if (selectedDate != null) {
      await ref.read(creditDetailInputProvider.notifier).setCreditDetailDate(pos: pos, date: selectedDate.yyyymmdd);
    }
  }

  ///
  Future<void> _inputCreditDetail() async {
    final creditDetailState = ref.watch(creditDetailInputProvider);

    final list = <CreditDetail>[];

    var errFlg = false;

    for (var i = 0; i < roopNum; i++) {
      //===============================================
      if (creditDetailState.creditDetailInputPrices[i] != 0) {
        list.add(CreditDetail()
          ..yearmonth = widget.creditDate.yyyymm
          ..creditDate = widget.creditDate.yyyymmdd
          ..creditPrice = widget.creditPrice.toString()
          ..creditDetailDate = creditDetailState.creditDetailInputDates[i]
          ..creditDetailItem = creditDetailState.creditDetailInputItems[i]
          ..creditDetailPrice = creditDetailState.creditDetailInputPrices[i]
          ..creditDetailDescription = creditDetailState.creditDetailInputDescriptions[i]);
      }
      //===============================================
    }

    if (list.isEmpty) {
      errFlg = true;
    }

    if (creditDetailState.diff == 0) {
      errFlg = true;
    }

    list.forEach((element) {
      [
        [element.creditDetailPrice, 10],
        [element.creditDetailDescription, 30]
      ].forEach((element2) {
        if (checkInputValueLengthCheck(value: element2[0].toString(), length: element2[1] as int) == false) {
          errFlg = true;
        }
      });
    });

    if (errFlg) {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    await CreditDetailsRepository().deleteCreditDetailList(isar: widget.isar, creditDetailList: widget.creditDetailList);

    await CreditDetailsRepository()
        .inputCreditDetailList(isar: widget.isar, creditDetailList: list)
        .then((value) async => ref.read(creditDetailInputProvider.notifier).clearInputValue().then((value) => Navigator.pop(context)));
  }

  ///
  Future<void> _clearOneBox({required int pos}) async {
    _priceTecs[pos].clear();
    _descriptionTecs[pos].clear();

    await ref.read(creditDetailInputProvider.notifier).clearOneBox(pos: pos);
  }
}

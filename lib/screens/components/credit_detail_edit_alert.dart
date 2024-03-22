import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../collections/credit_item.dart';
import '../../extensions/extensions.dart';
import '../../repository/credit_details_repository.dart';
import '../../state/credit_detail_edit/credit_detail_edit_notifier.dart';
import '../../utility/function.dart';
import 'parts/error_dialog.dart';

class CreditDetailEditAlert extends ConsumerStatefulWidget {
  const CreditDetailEditAlert({super.key, required this.isar, required this.creditDetail, required this.creditItemList, required this.from});

  final Isar isar;
  final CreditDetail creditDetail;
  final List<CreditItem> creditItemList;
  final String from;

  @override
  ConsumerState<CreditDetailEditAlert> createState() => _CreditDetailEditAlertState();
}

class _CreditDetailEditAlertState extends ConsumerState<CreditDetailEditAlert> {
  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();

  ///
  @override
  void initState() {
    super.initState();

    _makeTecs();
  }

  ///
  Future<void> _makeTecs() async {
    await Future(() => ref.read(creditDetailEditProvider.notifier).setUpdateCreditDetail(updateCreditDetail: widget.creditDetail));

    priceTextEditingController.text = widget.creditDetail.creditDetailPrice.toString();
    descriptionTextEditingController.text = widget.creditDetail.creditDetailDescription;
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
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Credit Detail Edit'), Container()],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              _displayInputParts(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  GestureDetector(
                    onTap: _inputEditCreditDetail,
                    child: Text(
                      'クレジット詳細レコードを更新する',
                      style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayInputParts() {
    final creditDetailEditState = ref.watch(creditDetailEditProvider);

    final date = creditDetailEditState.creditDetailEditDate;
    final item = creditDetailEditState.creditDetailEditItem;
    final price = creditDetailEditState.creditDetailEditPrice;
    final description = creditDetailEditState.creditDetailEditDescription;

    var blankAlert = false;
    if (price != 0) {
      [date, item, description].forEach((element) {
        if (element == '') {
          blankAlert = true;
        }
      });
    }

    final itemList = <CreditItem>[CreditItem()..name = ''];
    widget.creditItemList.forEach(itemList.add);

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 24, spreadRadius: 16, color: Colors.black.withOpacity(0.2))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
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
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _showDP,
                          child: Icon(Icons.calendar_month, color: Colors.greenAccent.withOpacity(0.6)),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: context.screenSize.width / 6,
                          child: Text(creditDetailEditState.creditDetailEditDate, style: const TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(onTap: _clearOneBox, child: const Icon(Icons.close, color: Colors.redAccent)),
                  ],
                ),
                DropdownButton(
                  isExpanded: true,
                  dropdownColor: Colors.pinkAccent.withOpacity(0.1),
                  iconEnabledColor: Colors.white,
                  items: itemList.map((e) => DropdownMenuItem(value: e.name, child: Text(e.name, style: const TextStyle(fontSize: 12)))).toList(),
                  value: creditDetailEditState.creditDetailEditItem,
                  onChanged: (value) => ref.read(creditDetailEditProvider.notifier).setCreditDetailItem(item: value!),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: priceTextEditingController,
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
                      ref.read(creditDetailEditProvider.notifier).setCreditDetailPrice(price: value.toInt());
                    }
                  },
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionTextEditingController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    hintText: '詳細(30文字以内)',
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                  ),
                  style: const TextStyle(fontSize: 12),
                  onChanged: (value) => ref.read(creditDetailEditProvider.notifier).setCreditDetailDescription(description: value),
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
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _showDP() async {
    final selectedDate = await showDatePicker(
      barrierColor: Colors.transparent,
      locale: const Locale('ja'),
      context: context,
      initialDate: DateTime.parse('${widget.creditDetail.creditDetailDate} 00:00:00'),
      firstDate: DateTime(DateTime.parse('${widget.creditDetail.creditDetailDate} 00:00:00').year,
          DateTime.parse('${widget.creditDetail.creditDetailDate} 00:00:00').month - 1),
      lastDate: DateTime(DateTime.parse('${widget.creditDetail.creditDetailDate} 00:00:00').year,
          DateTime.parse('${widget.creditDetail.creditDetailDate} 00:00:00').month + 2, 0),
    );

    if (selectedDate != null) {
      await ref.read(creditDetailEditProvider.notifier).setCreditDetailDate(date: selectedDate.yyyymmdd);
    }
  }

  ///
  Future<void> _clearOneBox() async {
    priceTextEditingController.clear();
    descriptionTextEditingController.clear();

    await ref.read(creditDetailEditProvider.notifier).clearOneBox();
  }

  ///
  Future<void> _inputEditCreditDetail() async {
    final creditDetailEditState = ref.watch(creditDetailEditProvider);

    final date = creditDetailEditState.creditDetailEditDate;
    final item = creditDetailEditState.creditDetailEditItem;
    final price = creditDetailEditState.creditDetailEditPrice;
    final description = creditDetailEditState.creditDetailEditDescription;

    var errFlg = false;

    [date, item, description].forEach((element) {
      if (element == '') {
        errFlg = true;
      }
    });

    if (price == 0) {
      errFlg = true;
    }

    if (errFlg == false) {
      [
        [price, 10],
        [description, 30]
      ].forEach((element) {
        if (checkInputValueLengthCheck(value: element[0].toString(), length: element[1] as int) == false) {
          errFlg = true;
        }
      });
    }

    if (errFlg) {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    await widget.isar.writeTxn(() async {
      await CreditDetailsRepository().getCreditDetail(isar: widget.isar, id: widget.creditDetail.id).then((value) {
        value!
          ..creditDetailDate = date
          ..creditDetailItem = item
          ..creditDetailPrice = price
          ..creditDetailDescription = description;

        CreditDetailsRepository().updateCreditDetail(isar: widget.isar, creditDetail: value).then((value) {
          Navigator.pop(context);

          if (widget.from == 'SameItemListAlert') {
            Navigator.pop(context);
          }
        });
      });
    });
  }
}

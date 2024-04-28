import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../collections/credit.dart';
import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';
import '../../repository/credit_details_repository.dart';
import '../../repository/credits_repository.dart';
import '../../utility/function.dart';

class CreditPriceEditAlert extends StatefulWidget {
  const CreditPriceEditAlert({super.key, required this.date, required this.isar, required this.creditPrice});

  final DateTime date;
  final Isar isar;
  final int creditPrice;

  ///
  @override
  State<CreditPriceEditAlert> createState() => _CreditPriceEditAlertState();
}

class _CreditPriceEditAlertState extends State<CreditPriceEditAlert> {
  final TextEditingController _creditPriceEditingController = TextEditingController();

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.date.yyyymmdd),
                      Text(widget.creditPrice.toString().toCurrency()),
                    ],
                  ),
                  Container(),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              _displayInputParts(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  GestureDetector(
                    onTap: _editCreditPrice,
                    child: Text(
                      '金額を変更する',
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
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 24, spreadRadius: 16, color: Colors.black.withOpacity(0.2))]),
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
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _creditPriceEditingController,
              decoration: const InputDecoration(labelText: '金額(10桁以内)'),
              style: const TextStyle(fontSize: 13, color: Colors.white),
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            ),
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _editCreditPrice() async {
    var errFlg = false;

    if (_creditPriceEditingController.text == '') {
      errFlg = true;
    }

    if (errFlg == false) {
      [
        [_creditPriceEditingController.text, 10]
      ].forEach((element) {
        if (checkInputValueLengthCheck(value: element[0].toString(), length: element[1] as int) == false) {
          errFlg = true;
        }
      });
    }

    //======================
    var credit = Credit();
    await CreditsRepository().getCreditByDateAndPrice(
        isar: widget.isar, param: {'date': widget.date.yyyymmdd, 'price': widget.creditPrice}).then((value) => credit = value!);
    //======================

    await widget.isar.writeTxn(() async {
      await CreditDetailsRepository().getCreditDetailListByDateAndPrice(
        isar: widget.isar,
        param: {'date': widget.date.yyyymmdd, 'price': widget.creditPrice.toString()},
      ).then((value) async {
        final creditDetailList = <CreditDetail>[];
        value?.forEach((element) => creditDetailList.add(element..creditPrice = _creditPriceEditingController.text));

        await CreditDetailsRepository().updateCreditDetailList(isar: widget.isar, creditDetailList: creditDetailList).then((value2) async {
          await CreditsRepository()
              .updateCredit(isar: widget.isar, credit: credit..price = _creditPriceEditingController.text.toInt())
              .then((value4) async {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        });
      });
    });
  }
}

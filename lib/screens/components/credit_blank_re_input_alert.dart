import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit.dart';
import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';
import '../../model/credit_blank_input_value.dart';
import '../../repository/credit_details_repository.dart';
import '../../state/app_params/app_params_notifier.dart';
import '../../state/app_params/app_params_response_state.dart';
import 'parts/error_dialog.dart';

class CreditBlankReInputAlert extends ConsumerStatefulWidget {
  const CreditBlankReInputAlert(
      {super.key,
      required this.isar,
      required this.date,
      required this.creditList,
      required this.creditBlankCreditDetailList});

  final Isar isar;
  final DateTime date;
  final List<Credit>? creditList;
  final List<CreditDetail> creditBlankCreditDetailList;

  @override
  ConsumerState<CreditBlankReInputAlert> createState() =>
      _CreditBlankReInputAlertState();
}

class _CreditBlankReInputAlertState
    extends ConsumerState<CreditBlankReInputAlert> {
  Map<int, CreditBlankInputValue> creditBlankInputValueMap =
      <int, CreditBlankInputValue>{};

  ///
  @override
  Widget build(BuildContext context) {
    final bool inputButtonClicked = ref.watch(appParamProvider
        .select((AppParamsResponseState value) => value.inputButtonClicked));

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
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Credit Blank ReInput'),
                      Text(widget.date.yyyymm)
                    ],
                  ),
                  ElevatedButton(
                    onPressed: inputButtonClicked
                        ? null
                        : () {
                            ref
                                .read(appParamProvider.notifier)
                                .setInputButtonClicked(flag: true);

                            _inputCreditBlankReInput();
                          },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent.withOpacity(0.2)),
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
  Widget _displayInputParts() {
    final List<Widget> list = <Widget>[];

    final Map<int, String> creditBlankSettingMap = ref.watch(appParamProvider
        .select((AppParamsResponseState value) => value.creditBlankSettingMap));

    for (int i = 0; i < widget.creditBlankCreditDetailList.length; i++) {
      list.add(DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 24,
                spreadRadius: 16,
                color: Colors.black.withOpacity(0.2))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 5,
                  right: 15,
                  child: Text(
                    (i + 1).toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 60,
                      color: (creditBlankInputValueMap[i] != null)
                          ? Colors.orangeAccent.withOpacity(0.2)
                          : Colors.white.withOpacity(0.2),
                    ),
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
                        color: (creditBlankInputValueMap[i] != null)
                            ? Colors.orangeAccent.withOpacity(0.4)
                            : Colors.white.withOpacity(0.2),
                        width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (widget.creditList!.isNotEmpty) ...<Widget>[
                        Wrap(
                            children: widget.creditList!.map((Credit e) {
                          return GestureDetector(
                            onTap: () {
                              ref
                                  .read(appParamProvider.notifier)
                                  .setCreditBlankSettingMap(
                                      pos: i, creditName: e.name);

                              creditBlankInputValueMap[i] =
                                  CreditBlankInputValue(
                                      widget.creditBlankCreditDetailList[i].id,
                                      e.name,
                                      e.date,
                                      e.price.toString());
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: CircleAvatar(
                                backgroundColor:
                                    (creditBlankSettingMap[i] == e.name)
                                        ? Colors.orangeAccent.withOpacity(0.4)
                                        : Colors.black,
                                child: Text(e.name,
                                    style: const TextStyle(
                                        fontSize: 8, color: Colors.white)),
                              ),
                            ),
                          );
                        }).toList()),
                        const SizedBox(height: 10),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(widget
                              .creditBlankCreditDetailList[i].creditDetailDate),
                          Text(widget
                              .creditBlankCreditDetailList[i].creditDetailPrice
                              .toString()
                              .toCurrency()),
                        ],
                      ),
                      Text(widget
                          .creditBlankCreditDetailList[i].creditDetailItem),
                      Text(widget.creditBlankCreditDetailList[i]
                          .creditDetailDescription),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(),
                          GestureDetector(
                            onTap: () => deleteCreditBlankData(
                                id: widget.creditBlankCreditDetailList[i].id),
                            child: Text('delete',
                                style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          )
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
  Future<void> _inputCreditBlankReInput() async {
    final List<CreditDetail> updateCreditDetailList = <CreditDetail>[];

    await widget.isar.writeTxn(() async => creditBlankInputValueMap.forEach(
        (int key, CreditBlankInputValue value) => CreditDetailsRepository()
                .getCreditDetail(isar: widget.isar, id: value.creditDetailId)
                .then((CreditDetail? value2) {
              updateCreditDetailList.add(value2!
                ..creditDate = value.creditDate
                ..creditPrice = value.creditPrice);
            })));

    if (updateCreditDetailList.isEmpty) {
      // ignore: always_specify_types
      Future.delayed(
        Duration.zero,
        () => error_dialog(
            context: context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      await ref
          .read(appParamProvider.notifier)
          .setInputButtonClicked(flag: false);

      return;
    }

    await widget.isar.writeTxn(() async => CreditDetailsRepository()
            .updateCreditDetailList(
                isar: widget.isar, creditDetailList: updateCreditDetailList)
            // ignore: always_specify_types
            .then((value) {
          Navigator.pop(context);
          Navigator.pop(context);
        }));
  }

  ///
  Future<void> deleteCreditBlankData({required Id id}) async =>
      CreditDetailsRepository()
          .deleteCreditDetail(isar: widget.isar, id: id)
          // ignore: always_specify_types
          .then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
      });
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit.dart';
import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';
import '../../repository/credit_details_repository.dart';
import '../../repository/credits_repository.dart';
import '../../state/app_params/app_params_notifier.dart';
import '../../state/app_params/app_params_response_state.dart';
import '../../state/credit/credit_notifier.dart';
import '../../state/credit/credit_response_state.dart';
import '../../utility/function.dart';
import '../home_screen.dart';
import 'credit_blank_re_input_alert.dart';
import 'parts/credit_dialog.dart';
import 'parts/error_dialog.dart';

class CreditInputAlert extends ConsumerStatefulWidget {
  const CreditInputAlert(
      {super.key,
      required this.isar,
      required this.date,
      this.creditList,
      required this.creditBlankCreditDetailList});

  final Isar isar;
  final DateTime date;
  final List<Credit>? creditList;

  final List<CreditDetail> creditBlankCreditDetailList;

  @override
  ConsumerState<CreditInputAlert> createState() => _CreditInputAlertState();
}

class _CreditInputAlertState extends ConsumerState<CreditInputAlert> {
  final List<TextEditingController> _creditNameTecs = <TextEditingController>[];
  final List<TextEditingController> _creditPriceTecs =
      <TextEditingController>[];

  List<Credit> deleteCreditList = <Credit>[];

  ///
  @override
  void initState() {
    super.initState();

    _makeTecs();
  }

  ///
  Future<void> _makeTecs() async {
    for (int i = 0; i < 10; i++) {
      _creditNameTecs.add(TextEditingController(text: ''));
      _creditPriceTecs.add(TextEditingController(text: ''));
    }

    if (widget.creditList!.isNotEmpty) {
      // ignore: always_specify_types
      await Future(() => ref
          .read(creditProvider.notifier)
          .setUpdateCredit(updateCredit: widget.creditList!));

      for (int i = 0; i < widget.creditList!.length; i++) {
        _creditNameTecs[i].text = widget.creditList![i].name.trim();
        _creditPriceTecs[i].text =
            widget.creditList![i].price.toString().trim();
      }
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    final bool inputButtonClicked = ref.watch(appParamProvider
        .select((AppParamsResponseState value) => value.inputButtonClicked));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DefaultTextStyle(
          style: GoogleFonts.kiwiMaru(fontSize: 12),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Credit Input'),
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

                            _inputCredit();
                          },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent.withOpacity(0.2)),
                    child: const Text('input'),
                  ),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              if (widget.creditBlankCreditDetailList.isNotEmpty) ...<Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'クレジットカードに紐づいていない当月の詳細情報が存在します。',
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(appParamProvider.notifier)
                            .setInputButtonClicked(flag: false);

                        ref
                            .read(appParamProvider.notifier)
                            .setCreditBlankDefaultMap();

                        CreditDialog(
                          context: context,
                          widget: CreditBlankReInputAlert(
                            isar: widget.isar,
                            date: widget.date,
                            creditList: widget.creditList,
                            creditBlankCreditDetailList:
                                widget.creditBlankCreditDetailList,
                          ),
                        );
                      },
                      child: Icon(Icons.info_outline,
                          color: Colors.greenAccent.withOpacity(0.6)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
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

    final CreditResponseState creditInputState = ref.watch(creditProvider);

    for (int i = 0; i < 10; i++) {
      final String date = creditInputState.creditDates[i];
      final String name = creditInputState.creditNames[i];
      final int price = creditInputState.creditPrices[i];

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
                      color: (date != '' && name != '' && price != -1)
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
                        color: (date != '' && name != '' && price != -1)
                            ? Colors.orangeAccent.withOpacity(0.4)
                            : Colors.white.withOpacity(0.2),
                        width: 2),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => _showDP(pos: i),
                                child: Icon(Icons.calendar_month,
                                    color: Colors.greenAccent.withOpacity(0.6)),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                  width: context.screenSize.width / 6,
                                  child: Text(date,
                                      style: const TextStyle(fontSize: 10))),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              _addingDeleteCreditList(date: date, price: price);

                              _clearOneBox(pos: i);
                            },
                            child: const Icon(Icons.close,
                                color: Colors.redAccent),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _creditNameTecs[i],
                              decoration: const InputDecoration(
                                  labelText: 'クレジット名(15文字以内)'),
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.white),
                              onTapOutside: (PointerDownEvent event) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              onChanged: (String value) {
                                if (value != '') {
                                  ref
                                      .read(creditProvider.notifier)
                                      .setCreditName(
                                          pos: i, name: value.trim());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _creditPriceTecs[i],
                              decoration:
                                  const InputDecoration(labelText: '金額(10桁以内)'),
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.white),
                              onTapOutside: (PointerDownEvent event) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              onChanged: (String value) {
                                if (value != '') {
                                  ref
                                      .read(creditProvider.notifier)
                                      .setCreditPrice(
                                          pos: i, price: value.trim().toInt());
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

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => list[index],
            childCount: list.length,
          ),
        ),
      ],
    );
  }

  ///
  Future<void> _showDP({required int pos}) async {
    final DateTime? selectedDate = await showDatePicker(
      barrierColor: Colors.transparent,
      locale: const Locale('ja'),
      context: context,
      initialDate: DateTime(widget.date.year, widget.date.month),
      firstDate: DateTime(widget.date.year, widget.date.month),
      lastDate: DateTime(widget.date.year, widget.date.month + 1, 0),
    );

    if (selectedDate != null) {
      await ref
          .read(creditProvider.notifier)
          .setCreditDate(pos: pos, date: selectedDate.yyyymmdd);
    }
  }

  ///
  Future<void> _inputCredit() async {
    final CreditResponseState creditInputState = ref.watch(creditProvider);

    final List<Credit> list = <Credit>[];

    bool errFlg = false;

    ////////////////////////// 同数チェック
    int creditDateCount = 0;
    int creditNameCount = 0;
    int creditPriceCount = 0;
    ////////////////////////// 同数チェック

    for (int i = 0; i < 10; i++) {
      if (creditInputState.creditDates[i] != '' &&
          creditInputState.creditNames[i] != '' &&
          creditInputState.creditPrices[i] > -1) {
        list.add(
          Credit()
            ..date = creditInputState.creditDates[i]
            ..name = creditInputState.creditNames[i]
            ..price = creditInputState.creditPrices[i],
        );
      }

      if (creditInputState.creditDates[i] != '') {
        creditDateCount++;
      }

      if (creditInputState.creditNames[i] != '') {
        creditNameCount++;
      }

      if (creditInputState.creditPrices[i] > -1) {
        creditPriceCount++;
      }
    }

    if (list.isEmpty) {
      errFlg = true;
    }

    ////////////////////////// 同数チェック
    final Map<int, String> countCheck = <int, String>{};
    countCheck[creditDateCount] = '';
    countCheck[creditNameCount] = '';
    countCheck[creditPriceCount] = '';

    // 同数の場合、要素数は1になる
    if (countCheck.length > 1) {
      errFlg = true;
    }
    ////////////////////////// 同数チェック

    if (!errFlg) {
      for (final Credit element in list) {
        for (final List<Object> element2 in <List<Object>>[
          <Object>[element.name, 15],
          <int>[element.price, 10]
        ]) {
          if (!checkInputValueLengthCheck(
              value: element2[0].toString(), length: element2[1] as int)) {
            errFlg = true;
          }
        }
      }
    }

    if (errFlg) {
      // ignore: always_specify_types
      Future.delayed(
        Duration.zero,
        () {
          if (mounted) {
            return error_dialog(
                context: context, title: '登録できません。', content: '値を正しく入力してください。');
          }
        },
      );

      await ref
          .read(appParamProvider.notifier)
          .setInputButtonClicked(flag: false);

      return;
    }

    //---------------------------//
    final IsarCollection<Credit> creditsCollection =
        CreditsRepository().getCollection(isar: widget.isar);
    final List<Credit> getCredits = await creditsCollection
        .filter()
        .dateStartsWith(widget.date.yyyymm)
        .findAll();
    if (getCredits.isNotEmpty) {
      await CreditsRepository()
          .deleteCreditList(isar: widget.isar, creditList: getCredits);
    }
    //---------------------------//

    //---------------------------//
    for (final Credit element in deleteCreditList) {
      final Map<String, dynamic> param = <String, dynamic>{};
      param['date'] = element.date;
      param['price'] = element.price.toString();
      CreditDetailsRepository()
          .getCreditDetailListByDateAndPrice(isar: widget.isar, param: param)
          .then((List<CreditDetail>? value) async => widget.isar.writeTxn(
              () async => value?.forEach((CreditDetail element2) =>
                  CreditDetailsRepository().updateCreditDetail(
                      isar: widget.isar,
                      creditDetail: element2
                        ..creditDate = ''
                        ..creditPrice = ''))));
    }
    //---------------------------//

    await CreditsRepository()
        .inputCreditList(isar: widget.isar, creditList: list)
        // ignore: always_specify_types
        .then((value) async => ref
                .read(creditProvider.notifier)
                .clearInputValue()
                // ignore: always_specify_types
                .then((value) {
              if (mounted) {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  // ignore: inference_failure_on_instance_creation, always_specify_types
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        HomeScreen(isar: widget.isar),
                  ),
                );
              }
            }));
  }

  ///
  Future<void> _clearOneBox({required int pos}) async {
    _creditNameTecs[pos].clear();
    _creditPriceTecs[pos].clear();

    await ref.read(creditProvider.notifier).clearOneBox(pos: pos);
  }

  ///
  void _addingDeleteCreditList({required String date, required int price}) =>
      setState(() => deleteCreditList.add(Credit()
        ..date = date
        ..price = price));
}

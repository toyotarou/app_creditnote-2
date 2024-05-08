import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../collections/config.dart';
import '../collections/credit.dart';
import '../collections/credit_detail.dart';
import '../collections/credit_item.dart';
import '../collections/subscription_item.dart';
import '../extensions/extensions.dart';
import '../repository/credit_details_repository.dart';
import '../repository/credit_items_repository.dart';
import '../repository/credits_repository.dart';
import '../repository/subscription_items_repository.dart';
import '../state/app_params/app_params_notifier.dart';
import 'components/categories_price_list_alert.dart';
import 'components/config_setting_alert.dart';
import 'components/credit_detail_edit_alert.dart';
import 'components/credit_detail_input_alert.dart';
import 'components/credit_input_alert.dart';
import 'components/credit_item_input_alert.dart';
import 'components/download_data_list_alert.dart';
import 'components/monthly_credit_item_list_alert.dart';
import 'components/parts/back_ground_image.dart';
import 'components/parts/circle_painter.dart';
import 'components/parts/credit_dialog.dart';
import 'components/parts/menu_head_icon.dart';
import 'components/same_item_list_alert.dart';
import 'components/yearly_credit_category_list_alert.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.isar});

  final Isar isar;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Config>? configList = [];

  Map<String, String> settingConfigMap = {};

  List<Credit>? creditList = [];

  List<CreditItem>? creditItemList = [];

  List<CreditDetail>? creditDetailList = [];

  List<ScrollController> _scrollControllers = [];

  List<String> selectedYearmonthList = [];

  final _radius = 10.0;

  final _backRadius = 20.0;

  late AnimationController _animationController;

  late Animation<double> _animationRadius;

  List<SubscriptionItem>? subscriptionItemList = [];

  bool allSameNumFlag = false;

  ///
  @override
  void initState() {
    _animationController = AnimationController(duration: const Duration(seconds: 3), vsync: this);

    _animationRadius = Tween(begin: 0.toDouble(), end: _backRadius).animate(_animationController)..addListener(() => setState(() {}));

    _animationController.repeat();

    super.initState();
  }

  ///
  void _init() {
    _makeSettingConfigMap();

    _makeCreditList();

    _makeCreditItemList();

    _makeCreditDetailList();

    _makeSubscriptionItemList();
  }

  ///
  @override
  Widget build(BuildContext context) {
    Future(_init);

    _scrollControllers = List.generate(1000, (index) => ScrollController());

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          const BackGroundImage(),
          Container(
            width: context.screenSize.width,
            height: context.screenSize.height,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Credit Note'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              CreditDialog(
                                context: context,
                                widget: YearlyCreditCategoryListAlert(
                                  isar: widget.isar,
                                  creditItemList: creditItemList,
                                  creditDetailList: creditDetailList,
                                  selectedYearmonthList: selectedYearmonthList,
                                ),
                              );
                            },
                            icon: Icon(Icons.list, color: Colors.greenAccent.withOpacity(0.4), size: 20),
                          ),
                          IconButton(
                            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                            icon: Icon(Icons.settings, color: Colors.greenAccent.withOpacity(0.4), size: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                if (settingConfigMap['start_yearmonth'] != null) ...[Expanded(child: _displayYearmonthList())],
              ],
            ),
          ),
        ],
      ),
      drawer: _dispDrawer(),
      endDrawer: _dispEndDrawer(),
      endDrawerEnableOpenDragGesture: false,
    );
  }

  ///
  Widget _dispDrawer() {
    return Drawer(
      backgroundColor: Colors.blueGrey.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                final creditItemCountMap = <String, List<CreditDetail>>{};
                creditDetailList?.forEach((element) => creditItemCountMap[element.creditDetailItem] = []);
                creditDetailList?.forEach((element) => creditItemCountMap[element.creditDetailItem]?.add(element));

                CreditDialog(
                  context: context,
                  widget: ConfigSettingAlert(isar: widget.isar, creditItemCountMap: creditItemCountMap),
                );
              },
              child: Row(
                children: [
                  const MenuHeadIcon(),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                      margin: const EdgeInsets.all(5),
                      child: const Text('設定'),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                final creditItemCountMap = <String, List<CreditDetail>>{};
                creditDetailList?.forEach((element) => creditItemCountMap[element.creditDetailItem] = []);
                creditDetailList?.forEach((element) => creditItemCountMap[element.creditDetailItem]?.add(element));

                CreditDialog(
                  context: context,
                  widget: CreditItemInputAlert(isar: widget.isar, creditItemList: creditItemList ?? [], creditItemCountMap: creditItemCountMap),
                );
              },
              child: Row(
                children: [
                  const MenuHeadIcon(),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                      margin: const EdgeInsets.all(5),
                      child: const Text('分類アイテム管理'),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                CreditDialog(
                  context: context,
                  clearBarrierColor: true,
                  widget: DownloadDataListAlert(
                    isar: widget.isar,
                    selectedYearmonthList: selectedYearmonthList,
                    creditList: creditList ?? [],
                    creditDetailList: creditDetailList ?? [],
                    allSameNumFlag: allSameNumFlag,
                  ),
                );
              },
              child: Row(
                children: [
                  const MenuHeadIcon(),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                      margin: const EdgeInsets.all(5),
                      child: const Text('データダウンロード'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget _dispEndDrawer() {
    final homeListSelectedYearmonth = ref.watch(appParamProvider.select((value) => value.homeListSelectedYearmonth));

    //===============================
    var sum = 0;
    final creList = <Credit>[];
    creditList?.forEach((element) {
      final exDate = element.date.split('-');
      if (homeListSelectedYearmonth == '${exDate[0]}-${exDate[1]}') {
        sum += element.price;
        creList.add(element);
      }
    });
    //===============================

    final subscriptionItems = <String>[];
    subscriptionItemList?.forEach((element) => subscriptionItems.add(element.name));

    var subscriptionTotal = 0;
    creditDetailList!.where((element) => element.yearmonth == homeListSelectedYearmonth).toList().forEach((element) {
      if (subscriptionItems.contains(element.creditDetailDescription)) {
        subscriptionTotal += element.creditDetailPrice;
      }
    });

    return GestureDetector(
      onHorizontalDragUpdate: (_) {},
      child: Container(
        width: context.screenSize.width,
        decoration: const BoxDecoration(color: Colors.transparent),
        padding: EdgeInsets.only(left: context.screenSize.width * 0.2),
        child: Drawer(
          backgroundColor: Colors.blueGrey.withOpacity(0.2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Column(
                children: [
                  const SizedBox(height: 60),
                  Stack(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 12, left: 12),
                          child: CustomPaint(painter: CirclePainter(_radius, _backRadius, _animationRadius.value))),
                      GestureDetector(
                        onTap: () {
                          ref.read(appParamProvider.notifier).setHomeListSelectedYearmonth(yearmonth: '');
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close, color: Colors.redAccent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(child: DecoratedBox(decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)), child: const SizedBox(width: 5))),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(homeListSelectedYearmonth),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(sum.toString().toCurrency()),
                            Text(subscriptionTotal.toString().toCurrency(), style: const TextStyle(color: Colors.yellowAccent)),
                          ],
                        ),
                      ],
                    ),
                    Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
                    Expanded(child: _displayCreditDetailList()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayCreditDetailList() {
    final list = <Widget>[];

    final homeListSelectedYearmonth = ref.watch(appParamProvider.select((value) => value.homeListSelectedYearmonth));

    final categoriesPriceMap = <String, List<CreditDetail>>{};

    final creditItemColorMap = <String, String>{};
    creditItemList?.forEach((element) {
      creditItemColorMap[element.name] = element.color;

      categoriesPriceMap[element.name] = [];
    });

    final subscriptionItems = <String>[];
    subscriptionItemList?.forEach((element) => subscriptionItems.add(element.name));

    if (creditDetailList != null) {
      /// 複数条件でソートする
      creditDetailList!.where((element) => element.yearmonth == homeListSelectedYearmonth).toList()
        ..sort((a, b) {
          final result = a.creditDetailDate.compareTo(b.creditDetailDate);
          if (result != 0) {
            return result;
          }
          return -1 * a.creditDetailPrice.compareTo(b.creditDetailPrice);
        })
        ..forEach((element) {
          final lineColor = (creditItemColorMap[element.creditDetailItem] != null && creditItemColorMap[element.creditDetailItem] != '')
              ? creditItemColorMap[element.creditDetailItem]
              : '0xffffffff';

          final subscriptionColor = (subscriptionItems.contains(element.creditDetailDescription)) ? Colors.yellowAccent : Colors.white;

          list.add(Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      CreditDialog(
                        context: context,
                        widget: SameItemListAlert(
                          isar: widget.isar,
                          creditDetail: element,
                          creditDetailList: creditDetailList,
                          creditItemList: creditItemList ?? [],
                          subscriptionItemList: subscriptionItemList ?? [],
                        ),
                      );
                    },
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.greenAccent.withOpacity(0.4),
                    icon: Icons.list,
                    padding: EdgeInsets.zero,
                  ),
                  SlidableAction(
                    onPressed: (_) {
                      CreditDialog(
                        context: context,
                        widget:
                            CreditDetailEditAlert(isar: widget.isar, creditDetail: element, creditItemList: creditItemList ?? [], from: 'HomeScreen'),
                      );
                    },
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.greenAccent.withOpacity(0.4),
                    icon: Icons.edit,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(element.creditDetailDate, style: TextStyle(color: subscriptionColor)),
                      Text(element.creditDetailDescription, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: subscriptionColor)),
                    ],
                  )),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(element.creditDetailPrice.toString().toCurrency(), style: TextStyle(color: subscriptionColor)),
                      Container(
                        width: context.screenSize.width / 6,
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Color(lineColor!.toInt()).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                        child: FittedBox(child: Text(element.creditDetailItem, style: TextStyle(fontSize: 10, color: subscriptionColor))),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.arrow_back_ios_sharp, color: Colors.white.withOpacity(0.3)),
                ],
              ),
            ),
          ));

          categoriesPriceMap[element.creditDetailItem]?.add(element);
        });

      final list2 = <Widget>[];
      creditItemList?.forEach((element) {
        if (categoriesPriceMap[element.name] != null) {
          final lineColor =
              (creditItemColorMap[element.name] != null && creditItemColorMap[element.name] != '') ? creditItemColorMap[element.name] : '0xffffffff';

          var sum = 0;
          categoriesPriceMap[element.name]?.forEach((element2) => sum += element2.creditDetailPrice);

          if (sum > 0) {
            list2.add(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      CreditDialog(
                        context: context,
                        widget: MonthlyCreditItemListAlert(
                          date: DateTime.parse('$homeListSelectedYearmonth-01 00:00:00'),
                          isar: widget.isar,
                          item: element.name,
                          creditDetailList: creditDetailList ?? [],
                        ),
                      );
                    },
                    child: Container(
                      width: context.screenSize.width / 6,
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Color(lineColor!.toInt()).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                      child: FittedBox(child: Text(element.name, style: const TextStyle(fontSize: 10), maxLines: 3, overflow: TextOverflow.ellipsis)),
                    ),
                  ),
                  Text(sum.toString().toCurrency()),
                ],
              ),
            ));
          }
        }
      });

      list
        ..add(const SizedBox(height: 30))
        ..add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            IconButton(
              onPressed: () {
                CreditDialog(
                  context: context,
                  widget: CategoriesPriceListAlert(
                    isar: widget.isar,
                    date: DateTime.parse('$homeListSelectedYearmonth-01 00:00:00'),
                    configList: configList,
                    creditItemList: creditItemList,
                    creditDetailList: creditDetailList,
                    index: (selectedYearmonthList..sort((a, b) => -1 * a.compareTo(b))).indexWhere((element) => element == homeListSelectedYearmonth),
                  ),
                );
              },
              icon: Icon(Icons.pages_rounded, color: Colors.greenAccent.withOpacity(0.4)),
            ),
          ],
        ))
        ..add(Column(children: list2));
    }

    return SingleChildScrollView(child: DefaultTextStyle(style: const TextStyle(fontSize: 12), child: Column(children: list)));
  }

  ///
  Future<void> _makeSettingConfigMap() async {
    final configsCollection = widget.isar.configs;

    final getConfigs = await configsCollection.where().findAll();

    setState(() {
      configList = getConfigs;

      getConfigs.forEach((element) => settingConfigMap[element.configKey] = element.configValue);
    });
  }

  ///
  Widget _displayYearmonthList() {
    selectedYearmonthList = [];

    final list = <Widget>[];

    final homeListSelectedYearmonth = ref.watch(appParamProvider.select((value) => value.homeListSelectedYearmonth));

    if (settingConfigMap['start_yearmonth'] != null && settingConfigMap['start_yearmonth'] != '') {
      final exYearmonth = settingConfigMap['start_yearmonth']!.split('-');

      if (exYearmonth.length > 1) {
        if (exYearmonth[0] != '' && exYearmonth[1] != '') {
          final firstDate = DateTime(exYearmonth[0].toInt(), exYearmonth[1].toInt());

          final diff = DateTime.now().difference(firstDate).inDays;

          final addNum = DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;

          final yearmonthList = <String>[];

          for (var i = 0; i <= (diff + addNum); i++) {
            final yearmonth = firstDate.add(Duration(days: i)).yyyymm;

            if (!yearmonthList.contains(yearmonth)) {
              //===============================
              var sum = 0;
              final creList = <Credit>[];
              creditList?.forEach((element) {
                final exDate = element.date.split('-');
                if (yearmonth == '${exDate[0]}-${exDate[1]}') {
                  sum += element.price;
                  creList.add(element);
                }
              });
              //===============================

              //===============================
              final itemBlankCreditDetailList = <CreditDetail>[];
              creditDetailList?.forEach((element) {
                if (yearmonth == element.yearmonth) {
                  if (element.creditDate == '' && element.creditPrice == '') {
                    itemBlankCreditDetailList.add(element);
                  }
                }
              });
              //===============================

              list.add(Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 70,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                                    decoration: BoxDecoration(
                                        color: (yearmonth == homeListSelectedYearmonth) ? Colors.yellowAccent.withOpacity(0.3) : Colors.transparent),
                                    child: Text(yearmonth),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        ref.read(appParamProvider.notifier).setInputButtonClicked(flag: false);

                                        CreditDialog(
                                          context: context,
                                          widget: CreditInputAlert(
                                            isar: widget.isar,
                                            date: DateTime.parse('$yearmonth-01 00:00:00'),
                                            creditList: creList,
                                            creditBlankCreditDetailList: itemBlankCreditDetailList,
                                          ),
                                        );
                                      },
                                      child: Icon(Icons.input, color: Colors.greenAccent.withOpacity(0.4)),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        ref.read(appParamProvider.notifier).setHomeListSelectedYearmonth(yearmonth: yearmonth);

                                        _scaffoldKey.currentState!.openEndDrawer();
                                      },
                                      child: Icon(Icons.list, color: Colors.greenAccent.withOpacity(0.4)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        )),
                    Expanded(
                      child: Container(
                        height: context.screenSize.height / 10,
                        decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.2))),
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: _scrollControllers[i],
                          child: ListView.separated(
                            controller: _scrollControllers[i],
                            itemBuilder: (context, index) {
                              //-----------------------------
                              final creDetList = <CreditDetail>[];
                              creditDetailList?.forEach((element) {
                                if (element.creditDate == creList[index].date && element.creditPrice == creList[index].price.toString()) {
                                  creDetList.add(element);
                                }
                              });
                              //-----------------------------

                              creDetList.sort((a, b) => a.creditDetailDate.compareTo(b.creditDetailDate));

                              ////////////////////////// 同数チェック
                              var inputedCreditDetailDateCount = 0;
                              var inputedCreditDetailItemCount = 0;
                              var inputedCreditDetailPriceCount = 0;
                              var inputedCreditDetailDescriptionCount = 0;
                              ////////////////////////// 同数チェック

                              var sum = 0;
                              creDetList.forEach((element) {
                                sum += element.creditDetailPrice;

                                ////////////////////////// 同数チェック
                                if (element.creditDetailDate != '') {
                                  inputedCreditDetailDateCount++;
                                }
                                if (element.creditDetailItem != '') {
                                  inputedCreditDetailItemCount++;
                                }
                                if (element.creditDetailPrice != 0) {
                                  inputedCreditDetailPriceCount++;
                                }
                                if (element.creditDetailDescription != '') {
                                  inputedCreditDetailDescriptionCount++;
                                }
                                ////////////////////////// 同数チェック
                              });

                              ////////////////////////// 同数チェック
                              final countCheck = <int, String>{};
                              countCheck[inputedCreditDetailDateCount] = '';
                              countCheck[inputedCreditDetailItemCount] = '';
                              countCheck[inputedCreditDetailPriceCount] = '';
                              countCheck[inputedCreditDetailDescriptionCount] = '';
                              final bool sameNumFlag;
                              if (countCheck.length > 1) {
                                sameNumFlag = false;
                              } else {
                                sameNumFlag = true;
                              }

                              if (sameNumFlag == false) {
                                allSameNumFlag = sameNumFlag;
                              }

                              ////////////////////////// 同数チェック

                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 30, child: Text(DateTime.parse('${creList[index].date} 00:00:00').day.toString().padLeft(2, '0'))),
                                    Expanded(
                                      child: Text(creList[index].name,
                                          style: const TextStyle(color: Colors.grey), maxLines: 2, overflow: TextOverflow.ellipsis),
                                    ),
                                    Container(width: 60, alignment: Alignment.topRight, child: Text(creList[index].price.toString().toCurrency())),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        ref.read(appParamProvider.notifier).setInputButtonClicked(flag: false);

                                        CreditDialog(
                                          context: context,
                                          widget: CreditDetailInputAlert(
                                            isar: widget.isar,
                                            creditDate: DateTime.parse('${creList[index].date} 00:00:00'),
                                            creditPrice: creList[index].price,
                                            creditItemList: creditItemList ?? [],
                                            creditDetailList: creDetList,
                                          ),
                                        );
                                      },
                                      child: Icon(Icons.input, size: 20, color: Colors.greenAccent.withOpacity(0.4)),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: (creList[index].price == sum)
                                            ? sameNumFlag
                                                ? Colors.greenAccent.withOpacity(0.3)
                                                : Colors.yellowAccent.withOpacity(0.3)
                                            : Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Container(),
                            itemCount: creList.length,
                          ),
                        ),
                      ),
                    ),
                    Container(width: 70, alignment: Alignment.topRight, child: Text(sum.toString().toCurrency())),
                  ],
                ),
              ));

              if (creList.isNotEmpty) {
                selectedYearmonthList.add(yearmonth);
              }
            }

            yearmonthList.add(yearmonth);
          }
        }
      }
    }

    return SingleChildScrollView(child: DefaultTextStyle(style: const TextStyle(fontSize: 12), child: Column(children: list)));
  }

  ///
  Future<void> _makeCreditList() async => CreditsRepository().getCreditList(isar: widget.isar).then((value) => setState(() => creditList = value));

  ///
  Future<void> _makeCreditItemList() async =>
      CreditItemsRepository().getCreditItemList(isar: widget.isar).then((value) => setState(() => creditItemList = value));

  ///
  Future<void> _makeCreditDetailList() async =>
      CreditDetailsRepository().getCreditDetailList(isar: widget.isar).then((value) => setState(() => creditDetailList = value));

  ///
  Future<void> _makeSubscriptionItemList() async =>
      SubscriptionItemsRepository().getSubscriptionItemList(isar: widget.isar).then((value) => setState(() => subscriptionItemList = value));
}

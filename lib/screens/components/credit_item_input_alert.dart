import 'dart:ui';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../collections/credit_item.dart';
import '../../extensions/extensions.dart';
import '../../repository/credit_items_repository.dart';
import 'parts/credit_item_card.dart';
import 'parts/error_dialog.dart';

class CreditItemInputAlert extends ConsumerStatefulWidget {
  const CreditItemInputAlert({super.key, required this.isar, required this.creditItemList, required this.creditItemCountMap});

  final Isar isar;

  final List<CreditItem> creditItemList;

  final Map<String, List<CreditDetail>> creditItemCountMap;

  @override
  ConsumerState<CreditItemInputAlert> createState() => _CreditItemInputAlertState();
}

class _CreditItemInputAlertState extends ConsumerState<CreditItemInputAlert> {
  final TextEditingController _creditItemEditingController = TextEditingController();

  List<DragAndDropItem> creditItemDDItemList = [];
  List<DragAndDropList> ddList = [];

  List<int> orderedIdList = [];

  Color mycolor = Colors.white;

  Map<int, String> creditItemColorMap = {};

  Map<int, String> creditItemNameMap = {};

  ///
  @override
  void initState() {
    super.initState();

    widget.creditItemList.forEach((element) {
      final colorCode = (element.color != '') ? element.color : '0xffffffff';

      creditItemDDItemList.add(
        DragAndDropItem(
          child: CreditItemCard(
            key: Key(element.id.toString()),
            name: element.name,
            deleteButtonPress: () => _showDeleteDialog(id: element.id),
            colorPickerButtonPress: () => _showColorPickerDialog(id: element.id),
            colorCode: colorCode,
            isar: widget.isar,
            creditItemCountMap: widget.creditItemCountMap,
          ),
        ),
      );

      creditItemColorMap[element.id] = element.color;

      creditItemNameMap[element.id] = element.name;
    });

    ddList.add(DragAndDropList(children: creditItemDDItemList));
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: DefaultTextStyle(
            style: GoogleFonts.kiwiMaru(fontSize: 12),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(width: context.screenSize.width),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('分類アイテム管理'), Container()],
                ),
                Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
                _displayInputParts(),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          GestureDetector(
                            onTap: _inputCreditItem,
                            child: Text(
                              '分類アイテムを追加する',
                              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          GestureDetector(
                            onTap: _settingReorderIds,
                            child: Text(
                              '並び順を保存する',
                              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: DragAndDropLists(
                      children: ddList,
                      onItemReorder: _itemReorder,
                      onListReorder: _listReorder,

                      ///
                      itemDecorationWhileDragging: const BoxDecoration(
                        color: Colors.black,
                        boxShadow: [BoxShadow(color: Colors.white, blurRadius: 4)],
                      ),

                      ///
                      lastListTargetSize: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayInputParts() {
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
            child: TextField(
              controller: _creditItemEditingController,
              decoration: const InputDecoration(labelText: '分類アイテム'),
              style: const TextStyle(fontSize: 13, color: Colors.white),
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            ),
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _inputCreditItem() async {
    if (_creditItemEditingController.text == '') {
      Future.delayed(
        Duration.zero,
        () => error_dialog(context: context, title: '登録できません。', content: '値を正しく入力してください。'),
      );

      return;
    }

    final creditItem = CreditItem()
      ..name = _creditItemEditingController.text
      ..order = widget.creditItemList.length + 1
      ..color = '0xffffffff';

    await CreditItemsRepository().inputCreditItem(isar: widget.isar, creditItem: creditItem).then((value) {
      _creditItemEditingController.clear();
      Navigator.pop(context);
    });
  }

  ///
  void _itemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      final movedItem = ddList[oldListIndex].children.removeAt(oldItemIndex);

      ddList[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  ///
  void _listReorder(int oldListIndex, int newListIndex) {}

  ///
  void _showDeleteDialog({required int id}) {
    final Widget cancelButton = TextButton(onPressed: () => Navigator.pop(context), child: const Text('いいえ'));

    final Widget continueButton = TextButton(
        onPressed: () {
          _deleteCreditItem(id: id);

          Navigator.pop(context);
        },
        child: const Text('はい'));

    final alert = AlertDialog(
      backgroundColor: Colors.blueGrey.withOpacity(0.3),
      content: const Text('このデータを消去しますか？'),
      actions: [cancelButton, continueButton],
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  ///
  Future<void> _deleteCreditItem({required int id}) async {
    //-----------------------------------
    final creditDetailsCollection = widget.isar.creditDetails;

    final getCreditDetails = await creditDetailsCollection.filter().creditDetailItemEqualTo(creditItemNameMap[id]!).findAll();

    await widget.isar
        .writeTxn(() async => getCreditDetails.forEach((element) async => widget.isar.creditDetails.put(element..creditDetailItem = '')));
    //-----------------------------------

    final creditItemsCollection = widget.isar.creditItems; //TODO
    await widget.isar.writeTxn(() async => creditItemsCollection.delete(id));

    if (mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  ///
  Future<void> _settingReorderIds() async {
    orderedIdList = [];

    for (final value in ddList) {
      for (final child in value.children) {
        orderedIdList.add(
            child.child.key.toString().replaceAll('[', '').replaceAll('<', '').replaceAll("'", '').replaceAll('>', '').replaceAll(']', '').toInt());
      }
    }

    final creditItemsCollection = widget.isar.creditItems;

    await widget.isar.writeTxn(() async {
      for (var i = 0; i < orderedIdList.length; i++) {
        final getCreditItem = await creditItemsCollection.filter().idEqualTo(orderedIdList[i]).findFirst();
        if (getCreditItem != null) {
          getCreditItem
            ..name = creditItemNameMap[orderedIdList[i]].toString()
            ..order = i;

          await widget.isar.creditItems.put(getCreditItem);
        }
      }
    });

    if (mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  ///
  void _showColorPickerDialog({required int id}) {
    if (creditItemColorMap[id] != null && creditItemColorMap[id] != '') {
      mycolor = Color(creditItemColorMap[id]!.toInt());
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey.withOpacity(0.3),
          title: const Text('Pick a color!', style: TextStyle(fontSize: 12)),
          content: BlockPicker(
            availableColors: const [
              Colors.white,
              Colors.pinkAccent,
              Colors.redAccent,
              Colors.deepOrangeAccent,
              Colors.orangeAccent,
              Colors.amberAccent,
              Colors.yellowAccent,
              Colors.lightGreenAccent,
              Colors.greenAccent,
              Colors.tealAccent,
              Colors.cyanAccent,
              Colors.lightBlueAccent,
              Colors.purpleAccent,
              Color(0xFFFBB6CE),
              Colors.grey,
            ],
            pickerColor: mycolor,
            onColorChanged: (Color color) async {
              mycolor = color;

              final exColor = color.toString().split(' ');
              var colorCode = '';
              if (exColor.length == 3) {
                colorCode = exColor[2].replaceAll('Color(', '').replaceAll(')', '');
              } else {
                colorCode = exColor[0].replaceAll('Color(', '').replaceAll(')', '');
              }

              await _updateColorCode(id: id, color: colorCode).then((value) {
                Navigator.pop(context);
                Navigator.pop(context);
              });
            },
          ),
        );
      },
    );
  }

  ///
  Future<void> _updateColorCode({required int id, required String color}) async {
    await widget.isar.writeTxn(() async {
      await CreditItemsRepository().getCreditItem(isar: widget.isar, id: id).then((value) async {
        value!.color = color;

        await CreditItemsRepository().updateCreditItem(isar: widget.isar, creditItem: value);
      });
    });
  }
}

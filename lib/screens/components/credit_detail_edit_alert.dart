import 'dart:ui';

import 'package:credit_note/collections/credit_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../collections/credit_detail.dart';
import '../../extensions/extensions.dart';

class CreditDetailEditAlert extends StatefulWidget {
  const CreditDetailEditAlert({super.key, required this.isar, required this.creditDetail, this.creditItemList});

  final Isar isar;
  final CreditDetail creditDetail;
  final List<CreditItem>? creditItemList;

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
                  Container(),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              _displayInputParts(),
            ],
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
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          // onTap: () => _showDP(pos: i),
                          //
                          //
                          //

                          child: Icon(Icons.calendar_month, color: Colors.greenAccent.withOpacity(0.6)),
                        ),
                        const SizedBox(width: 10),
                        // SizedBox(
                        //   width: context.screenSize.width / 6,
                        //   child: Text(creditDetailState.creditDetailInputDates[i], style: const TextStyle(fontSize: 10)),
                        // ),
                        //
                        //
                        //
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // _clearOneBox(pos: i);
                        //
                        //
                        //
                      },
                      child: const Icon(Icons.close, color: Colors.redAccent),
                    ),
                  ],
                ),
                // DropdownButton(
                //   isExpanded: true,
                //   dropdownColor: Colors.pinkAccent.withOpacity(0.1),
                //   iconEnabledColor: Colors.white,
                //   items: itemList.map((e) {
                //     return DropdownMenuItem(
                //       value: e.name,
                //       child: Text(e.name, style: const TextStyle(fontSize: 12)),
                //     );
                //   }).toList(),
                //   value: creditDetailState.creditDetailInputItems[i],
                //   onChanged: (value) => ref.read(creditDetailProvider.notifier).setCreditDetailItem(pos: i, item: value!),
                // ),
                // const SizedBox(height: 10),
                // TextField(
                //   keyboardType: TextInputType.number,
                //   controller: _priceTecs[i],
                //   decoration: const InputDecoration(
                //     isDense: true,
                //     contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                //     hintText: '金額',
                //     filled: true,
                //     border: OutlineInputBorder(),
                //     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                //   ),
                //   style: const TextStyle(fontSize: 12),
                //   onChanged: (value) {
                //     if (value != '') {
                //       ref.read(creditDetailProvider.notifier).setCreditDetailPrice(pos: i, price: value.toInt());
                //     } else {
                //       ref.read(creditDetailProvider.notifier).setCreditDetailPrice(pos: i, price: creditDetailState.baseDiff.toInt());
                //     }
                //   },
                //   onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                // ),
                // const SizedBox(height: 10),
                // TextField(
                //   controller: _descriptionTecs[i],
                //   decoration: const InputDecoration(
                //     isDense: true,
                //     contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                //     hintText: '詳細',
                //     filled: true,
                //     border: OutlineInputBorder(),
                //     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                //   ),
                //   style: const TextStyle(fontSize: 12),
                //   onChanged: (value) => ref.read(creditDetailProvider.notifier).setCreditDetailDescription(pos: i, description: value),
                //   onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                // ),
                // if (blankAlert) ...[
                //   const SizedBox(height: 10),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(),
                //       const Icon(Icons.ac_unit, size: 16, color: Colors.yellowAccent),
                //     ],
                //   ),
                // ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

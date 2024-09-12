import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../../collections/credit_detail.dart';
import '../../../extensions/extensions.dart';

class CreditItemCard extends StatelessWidget {
  const CreditItemCard({
    super.key,
    required this.name,
    required this.deleteButtonPress,
    required this.colorPickerButtonPress,
    required this.colorCode,
    required this.isar,
    required this.creditItemCountMap,
  });

  final String name;

  final VoidCallback deleteButtonPress;

  final VoidCallback colorPickerButtonPress;
  final String colorCode;

  final Isar isar;

  final Map<String, List<CreditDetail>> creditItemCountMap;

  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.2))),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(name, style: TextStyle(color: Color(colorCode.toInt())), maxLines: 1, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 10),
          Container(
            width: context.screenSize.width * 0.3,
            alignment: Alignment.topRight,
            child: Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      alignment: Alignment.topRight,
                      child: Text(
                        (creditItemCountMap[name] != null) ? creditItemCountMap[name]!.length.toString() : 0.toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                GestureDetector(onTap: colorPickerButtonPress, child: Icon(Icons.color_lens_outlined, color: Colors.white.withOpacity(0.2))),
                const SizedBox(width: 10),
                GestureDetector(onTap: deleteButtonPress, child: Icon(Icons.delete, color: Colors.white.withOpacity(0.2))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:inno_tutor/elements/horizontal_menu_item.dart';
import 'package:inno_tutor/elements/vertical_menu_item.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final void Function() onTap;
  const SideMenuItem({ Key key,
    this.itemName,
    this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context))
      return VerticalMenuItem(itemName: itemName, onTap: onTap);

    return HorizontalMenuItem(itemName: itemName, onTap: onTap);
  }
}

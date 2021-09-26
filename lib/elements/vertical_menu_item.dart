import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inno_tutor/constants/controllers.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import '../../constants/style.dart' as style;

class VerticalMenuItem extends StatelessWidget {
  final String itemName;
  final void Function() onTap;
  const VerticalMenuItem({ Key key,
    this.itemName,
    this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value){
        value
          ? menuController.onHover(itemName)
          : menuController.onHover("not hovering");
      },
      child: Obx(() => Container(
        color: menuController.isHovering(itemName) ?
        style.grey.withOpacity(0.2) : 
        menuController.isActive(itemName) ?
        style.darkGreen.withOpacity(0.2) :
        Colors.transparent,
        child: Row(children: [
          Visibility(
              visible: menuController.isHovering(itemName) || menuController.isActive(itemName),
              child: Container(width: 3, height: 100, color: style.darkGreen),
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true
            ),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: EdgeInsets.all(16),
              child: menuController.returnIconFor(itemName)),
              if (!menuController.isActive(itemName))
              Flexible(child: CustomText(
                text: itemName,
                color: menuController.isHovering(itemName) ? style.darkGrey : style.grey,
                size: 16,
                weight: FontWeight.w500
              )) else
              Flexible(child: CustomText(
                text: itemName,
                size: 17,
                color: style.darkGrey,
                weight: FontWeight.bold,)
              )
            ],
          ))
        ],),
      )),
    );
  }
}

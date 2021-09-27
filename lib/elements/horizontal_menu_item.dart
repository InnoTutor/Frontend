import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inno_tutor/constants/controllers.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import '../../constants/style.dart' as style;

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final Function onTap;
  const HorizontalMenuItem({ Key key,
    this.itemName,
    this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      onHover: (value){
        value ?
        menuController.onHover(itemName) :
        menuController.onHover("not hovering");
      },
      child: Obx(()=> Container(
        color: menuController.isHovering(itemName) ?
        style.grey.withOpacity(0.2) : 
        menuController.isActive(itemName) ?
        style.darkGreen.withOpacity(0.2) :
        Colors.transparent,
        child: Row(
          children: [
            
            Visibility(
              visible: menuController.isHovering(itemName) || menuController.isActive(itemName),
              child: Container(width: 6, height: 40, color: style.darkGreen),
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true
            ),
            SizedBox(width: _width/100,),
            Padding(padding: EdgeInsets.only(right: 16, left: 4, bottom: 16, top: 16),
              child: menuController.returnIconFor(itemName)),
            if (!menuController.isActive(itemName))
              Flexible(child: CustomText(
                text: itemName,
                color: menuController.isHovering(itemName) ? style.darkGrey : style.darkGrey.withOpacity(0.6),
                size: 16,
                weight: FontWeight.w600
              )) else
              Flexible(child: CustomText(
                text: itemName,
                size: 16,
                color: style.darkGrey,
                weight: FontWeight.bold,)
              )
        ],)
      ))
    );
  }
}
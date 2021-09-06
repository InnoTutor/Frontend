import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/constants/controllers.dart';
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';
import 'package:inno_tutor_flutter/routing/routs.dart';
import 'package:inno_tutor_flutter/widgets/custom_text.dart';
import 'package:inno_tutor_flutter/widgets/side_menu_item.dart';

import 'logo.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      color: style.lightGrey,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: style.lightGreen,
                title: Row(
                  children: [
                    Logo(
                      path: 'icons/dark_logo.png',
                      height: 30,
                      leftPadding: 0,
                      rightPadding: 0
                    ),
                    SizedBox(width: _width/48),
                    Padding(padding: EdgeInsets.only(right: 5),
                    ),
                    Flexible(

                      child: CustomText(
                        text: "Dash",
                        size: 20,
                        weight: FontWeight.bold,
                        color: style.darkGrey
                      ),
                    ),
                  ],
                )
              ),
              //SizedBox(height: 15),
              SizedBox(width: _width/48,),
              Divider(color: style.grey.withOpacity(0.1)),
              Column(mainAxisSize: MainAxisSize.min,
                children: sideMenuItems.map((itemName) => SideMenuItem(
                  itemName: itemName,
                  onTap: (){
                    if (!menuController.isActive(itemName)){
                      menuController.changeActiveItemTo(itemName);
                      if (ResponsiveWidget.isSmallScreen(context))
                        Get.back();
                        // TODO: go it item name
                    }
                  }
                )).toList()
              )
            ],
          )
        ],
      ),
    );
  }
}

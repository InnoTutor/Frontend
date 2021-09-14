import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/constants/controllers.dart';
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';
import 'package:inno_tutor_flutter/routing/routs.dart';
import 'package:inno_tutor_flutter/widgets/custom_text.dart';
import 'package:inno_tutor_flutter/widgets/side_menu_item.dart';

import 'logo.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(mainAxisSize: MainAxisSize.min, children: [
              AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: style.lightGreen,
                  title: Row(
                    children: [
                      Logo(
                          path: 'assets/icons/dark_logo.png',
                          height: 30,
                          leftPadding: 0,
                          rightPadding: 0),
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                      ),
                    ],
                  )),
              Divider(
                color: style.grey.withOpacity(0.1),
                height: 10,
              ),
              Container(
                height: 100,
                color: style.lightGrey,
                child: (Row(children: [
                  Container(
                      padding: EdgeInsets.all(15),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person_outline,
                              color: style.almostDarkGrey))),
                  CustomText(
                      text: "Name\nSurname",
                      color: style.almostDarkGrey,
                      size: 18,
                      weight: FontWeight.w800)
                ])),
              )
            ]),
          Divider(
            color: style.grey.withOpacity(0.1),
            height: 10,
          ),
          Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems
                  .map((itemName) => SideMenuItem(
                      itemName: itemName,
                      onTap: () {
                          if (!menuController.isActive(itemName)) {
                            menuController.changeActiveItemTo(itemName);
                            if (ResponsiveWidget.isSmallScreen(context))
                              Get.back();
                            Navigator.pushNamed(context, itemName);
                          }
                      }))
                  .toList())
        ],
      ),
    );
  }
}

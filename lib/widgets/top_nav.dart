import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';

import 'custom_text.dart';
import 'logo.dart';

AppBar TopNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
  AppBar(
    leading: ResponsiveWidget.isSmallScreen(context) ?
    IconButton(icon: Icon(Icons.menu), onPressed: (){
      key.currentState?.openDrawer();
    },) : null,
    elevation:  0,
    backgroundColor: style.darkGreen,
    title: Row(
      children: [
        !ResponsiveWidget.isSmallScreen(context) ? Logo(
          height: 30,
          leftPadding: 20,
          rightPadding: 0
        ) : Container(),
        Expanded(
          child: Container()
        ),
        !ResponsiveWidget.isSmallScreen(context) ? CustomText(
          text: "Name Surname",
          size: 18,
          color: style.lightGrey,
          weight: FontWeight.w600,
        ) : Container(),
        Container(
          width: 15,
        ),
        Container(
          child: ResponsiveWidget.isSmallScreen(context) ? null : Container(
                padding: EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: style.lightGreen,
                  child: Icon(Icons.person_outline, 
                  color: style.darkGreen))
              )
          ),
        Container(
          width: 20,
        ),
        ResponsiveWidget.isSmallScreen(context) ? Logo(
            height: 30,
            leftPadding: 0,
            rightPadding: 0
        ) : Container(),
      ],
    ),
    iconTheme: IconThemeData(color: style.lightGrey),
  );
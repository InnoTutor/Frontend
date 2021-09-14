import 'package:flutter/material.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;

import 'custom_text.dart';

class PageCap extends StatelessWidget {
  final String text;
  const PageCap({ Key key, this.text }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20, top:20, bottom: 10),
          child: CustomText(
            selectable: true,
            fontFamily: 'roboto',
            text : text,
            size: 22,
            weight: FontWeight.normal,
            color: style.darkGrey,
          ),
        ),
        Divider(
          color: style.lightGrey,
          thickness: 2,
          height: 0,
        )
      ]
    );
  }
}
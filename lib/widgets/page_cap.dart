import 'package:flutter/material.dart';
import '../constants/style.dart' as style;

import 'custom_text.dart';

class PageCap extends StatelessWidget {
  String text;
  int padding;
  Color color;

  PageCap({ Key key, this.text, this.padding, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: padding ?? 20, top: padding ?? 20 , bottom: 10),
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
          color: color ?? style.lightGrey,
          thickness: 2,
          height: 0,
        )
      ]
    );
  }
}
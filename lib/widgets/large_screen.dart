import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/constants/controllers.dart';

import 'custom_text.dart';
import 'horizontal_menu_item.dart';

class LargeScreen extends StatelessWidget {
  final void Function() onTap;
  const LargeScreen({ Key key , this.onTap}) : super(key: key);

  get lightGrey => null;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Row(
        children: [
          Expanded(
            child: Container(
              color: style.lightGrey
          )),
          SizedBox(
            child: Container(
              width: 700,
              color: style.lightGrey,
              alignment: Alignment.topCenter,
              child: SizedBox(
                child: Container(
                  height: 600,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.all(Radius.circular(10)),
                    boxShadow:[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        spreadRadius: 5,
                        blurRadius: 7,
                      )
                    ]
                  )
                )
              )
            )
          ),
          Expanded(
            child: Container(
              color: style.lightGrey
          )),
        ],
      );
  }
}
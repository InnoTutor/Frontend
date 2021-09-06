import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';
import 'package:inno_tutor_flutter/widgets/side_menu.dart';

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
            color: style.lightGrey,
            child: Container(
            width: 700,
            color: style.lightGrey,
            alignment: Alignment.topRight,
            child: Container(
              child: Container(
                width: 230,
                height: ResponsiveWidget.isCustomSize(context) ? 520 : 300,
                margin: const EdgeInsets.only(right:5, left:5, top: 10),
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
                ),
                child: SideMenu(),
              )
            )
          )
          )
        ),
        SizedBox(
          child: Container(
            width: 700,
            color: style.lightGrey,
            alignment: Alignment.topCenter,
            child: SizedBox(
              child: Container(
                height: 600,
                margin: const EdgeInsets.only(right:5, left:5, top: 10),
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
          )
        ),
      ],
    );
  }
}
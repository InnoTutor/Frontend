import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inno_tutor/constants/style.dart' as style;
import 'package:inno_tutor/elements/drawer.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';
//import 'package:inno_tutor_flutter/widgets/side_menu.dart';

class LargeScreen extends StatelessWidget {
  final void Function() onTap;
  final Widget page;
  const LargeScreen({ Key key , this.onTap, this.page}) : super(key: key);

  get lightGrey => null;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
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
                  margin: const EdgeInsets.only(right:5, left:10, top: 10),
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
                  child: AppDrawer(),
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
                  ),
                  child: page,
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
      )
    );
  }
}
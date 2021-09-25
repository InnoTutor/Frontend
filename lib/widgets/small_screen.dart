import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/style.dart' as style;

class SmallScreen extends StatelessWidget {
  final Widget page;
  const SmallScreen({ Key key, this.page }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: style.lightGrey,
      child: page,
    );
  }
}
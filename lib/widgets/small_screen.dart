import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/helpers/local_navigator.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: style.lightGrey,
      child: localNavigator(),
    );
  }
}
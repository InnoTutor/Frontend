import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';
import 'package:inno_tutor_flutter/pages/my_profile/widgets/my_profile_large.dart';
import 'package:inno_tutor_flutter/widgets/custom_text.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isLargeScreen(context) ?
      MyProfileLargePage() : 
      Center(
      child: CustomText(
        text: "My Profile",
        size: 24,
        weight: FontWeight.w900,
        color: style.darkGrey
      )
    );
  }
}
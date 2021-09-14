import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';
import 'package:inno_tutor_flutter/pages/my_profile/widgets/my_profile_large.dart';
import 'package:inno_tutor_flutter/widgets/custom_text.dart';
import 'package:inno_tutor_flutter/constants/controllers.dart';

class MyProfile extends StatefulWidget {
  
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return !ResponsiveWidget.isSmallScreen(context) ?
      MyProfileLargePage() : 
      Center(
      child: CustomText(
        selectable: true,
        text: "My Profile",
        size: 24,
        weight: FontWeight.w900,
        color: style.darkGrey
      )
    );
  }
}
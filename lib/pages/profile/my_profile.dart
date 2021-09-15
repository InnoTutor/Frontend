import 'package:flutter/material.dart';
import 'package:inno_tutor/database/global_funtions.dart';
import 'package:inno_tutor/elements/drawer.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';
import 'package:inno_tutor/pages/profile/my_profile_large.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:inno_tutor/constants/style.dart' as style;

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async{
        final arguments = ModalRoute.of(context).settings.arguments;
        List<String>list = handle_arguments(arguments);
        Navigator.pushReplacementNamed(context,'/'+list[0] , arguments: {'route':list[1]} );

        return true;
      },
      child: !ResponsiveWidget.isSmallScreen(context) ?
        MyProfileLargePage() : 
        Center(
        child: CustomText(
          selectable: true,
          text: "My Profile",
          size: 24,
          weight: FontWeight.w900,
          color: style.darkGrey
        )
      )
    );
  }
}

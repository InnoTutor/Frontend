import 'package:flutter/material.dart';
import 'package:inno_tutor/constants/style.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';
import 'package:inno_tutor/pages/my_users/tutros/my_tutors_large_page.dart';
import 'package:inno_tutor/services/global_funtions.dart';
import 'package:inno_tutor/widgets/custom_text.dart';

class MyTutors extends StatefulWidget {
  @override
  _MyTutorsState createState() => _MyTutorsState();
}

class _MyTutorsState extends State<MyTutors> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final arguments = ModalRoute.of(context).settings.arguments;
        List<String>list = handle_arguments(arguments);
        Navigator.pushReplacementNamed(context,'/'+list[0] , arguments: {'route':list[1]} );

        return true;
      },
      child: !ResponsiveWidget.isSmallScreen(context) ?
        MyTutorsLargePage() :
        Center(
          child: CustomText(
            selectable: true,
            text: "My Tutors",
            size: 20,
            weight: FontWeight.bold,
            color: darkGrey
          )
        ),
    );
  }
}

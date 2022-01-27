import 'package:flutter/material.dart';
import 'package:inno_tutor/constants/style.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';
import 'package:inno_tutor/pages/my_users/students/my_students_large.dart';
import 'package:inno_tutor/services/global_funtions.dart';
import 'package:inno_tutor/widgets/custom_text.dart';

class MyStudents extends StatefulWidget {
  @override
  _MyStudentsState createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {
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
        MyStudentsLargePage() :
        Center(
          child: CustomText(
            selectable: true,
            text: "My Students",
            size: 20,
            weight: FontWeight.bold,
            color: darkGrey
          )
        ),
    );
  }
}

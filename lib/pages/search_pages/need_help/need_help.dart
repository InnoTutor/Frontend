import 'package:flutter/material.dart';
import 'package:inno_tutor/constants/style.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';
import 'package:inno_tutor/pages/search_pages/need_help/need_help_large.dart';
import 'package:inno_tutor/services/global_funtions.dart';
import 'package:inno_tutor/widgets/custom_text.dart';

class NeedHelp extends StatefulWidget {
  @override
  _NeedHelpState createState() => _NeedHelpState();
}

class _NeedHelpState extends State<NeedHelp> {

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
        NeedHelpLargePage() :
        Center(
        child: CustomText(
          selectable: true,
          text: "Need Help",
          size: 24,
          weight: FontWeight.w900,
          color: darkGrey
        )
      )
    );
  }
}

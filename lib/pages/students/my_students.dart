import 'package:flutter/material.dart';
import '../../database/global_funtions.dart';
import '../../elements/drawer.dart';
import '../../helpers/responsiveness.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/page_cap.dart';
import '../../constants/style.dart' as style;
class MyStudents extends StatefulWidget {
  @override
  _MyStudentsState createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

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
        PageCap(text: "My Students") :
        Center(
          child: CustomText(
            selectable: true,
            text: "My Students",
            size: 20,
            weight: FontWeight.bold,
            color: style.darkGrey
          )
        ),
    );
  }
}

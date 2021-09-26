import 'package:flutter/material.dart';
import '../../services/global_funtions.dart';
import '../../elements/drawer.dart';
import '../../helpers/responsiveness.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/page_cap.dart';
import '../../constants/style.dart' as style;

class MyRequests extends StatefulWidget {
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {

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
        PageCap(text: "My Requests") :
        Center(
          child: CustomText(
            selectable: true,
            text: "My Requests",
            size: 20,
            weight: FontWeight.bold,
            color: style.darkGrey
          )
        ),
    );
  }
}

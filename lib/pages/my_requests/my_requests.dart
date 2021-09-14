import 'package:flutter/widgets.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';
import 'package:inno_tutor_flutter/widgets/custom_text.dart';
import 'package:inno_tutor_flutter/widgets/page_cap.dart';

class MyRequests extends StatefulWidget {
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  @override
  Widget build(BuildContext context) {
    return !ResponsiveWidget.isSmallScreen(context) ?
    PageCap(text: "My Requests") :
    Center(
      child: CustomText(
        selectable: true,
        text: "My Requests",
        size: 20,
        weight: FontWeight.bold,
        color: style.darkGrey
      )
    );
  }
}
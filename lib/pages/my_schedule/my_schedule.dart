import 'package:flutter/widgets.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';
import 'package:inno_tutor_flutter/widgets/custom_text.dart';
import 'package:inno_tutor_flutter/widgets/page_cap.dart';

class MySchedule extends StatefulWidget {
  @override
  _MyScheduleState createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
  @override

  Widget build(BuildContext context) {
    return !ResponsiveWidget.isSmallScreen(context) ?
    PageCap(text: "My Schedule") :
    Center(
      child: CustomText(
        selectable: true,
        text: "My Schedule",
        size: 20,
        weight: FontWeight.bold,
        color: style.darkGrey
      )
    );
  }
}
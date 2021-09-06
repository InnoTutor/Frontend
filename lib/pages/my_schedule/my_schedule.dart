import 'package:flutter/widgets.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';
import 'package:inno_tutor_flutter/widgets/custom_text.dart';
import 'package:inno_tutor_flutter/widgets/page_cap.dart';

class MySchedulePage extends StatelessWidget {
  const MySchedulePage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isLargeScreen(context) ?
    PageCap(text: "My Schedule") :
    Center(
      child: CustomText(
        text: "My Schedule",
        size: 20,
        weight: FontWeight.bold,
        color: style.darkGrey
      )
    );
  }
}
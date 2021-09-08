import 'package:flutter/widgets.dart';
import 'package:inno_tutor_flutter/constants/style.dart' as style;
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';
import 'package:inno_tutor_flutter/widgets/custom_text.dart';
import 'package:inno_tutor_flutter/widgets/page_cap.dart';

class MyStudentsPage extends StatelessWidget {
  const MyStudentsPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !ResponsiveWidget.isSmallScreen(context) ?
    PageCap(text: "My Students") :
    Center(
      child: CustomText(
        text: "My Students",
        size: 20,
        weight: FontWeight.bold,
        color: style.darkGrey
      )
    );
  }
}
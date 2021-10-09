import 'package:flutter/material.dart';
import 'package:inno_tutor/widgets/page_cap.dart';

class NeedHelpLargePage extends StatefulWidget {
  const NeedHelpLargePage({ Key key }) : super(key: key);

  @override
  _NeedHelpLargePageState createState() => _NeedHelpLargePageState();
}

class _NeedHelpLargePageState extends State<NeedHelpLargePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageCap(text: "Need Help")
    );
  }
}
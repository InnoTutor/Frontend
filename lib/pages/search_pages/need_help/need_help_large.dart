import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/pages/search_pages/search_page.dart';

class NeedHelpLargePage extends StatefulWidget {
  const NeedHelpLargePage({ Key key }) : super(key: key);

  @override
  _NeedHelpLargePageState createState() => _NeedHelpLargePageState();
}

class _NeedHelpLargePageState extends State<NeedHelpLargePage> {
  
  Widget build(BuildContext context) {
    return SearchPage(
      searchTutors: true,
    );
  }
}
import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/pages/search_pages/search_page.dart';

class OfferHelpLargePage extends StatefulWidget {
  const OfferHelpLargePage({ Key key }) : super(key: key);

  @override
  _OfferHelpLargePageState createState() => _OfferHelpLargePageState();
}

class _OfferHelpLargePageState extends State<OfferHelpLargePage> {

  Widget build(BuildContext context) {
    return SearchPage(
      searchStudents: true,
    );
  }
}
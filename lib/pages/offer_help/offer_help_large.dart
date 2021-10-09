import 'package:flutter/material.dart';
import 'package:inno_tutor/widgets/page_cap.dart';

class OfferHelpLargePage extends StatefulWidget {
  const OfferHelpLargePage({ Key key }) : super(key: key);

  @override
  _OfferHelpLargePageState createState() => _OfferHelpLargePageState();
}

class _OfferHelpLargePageState extends State<OfferHelpLargePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageCap(text: "Offer Help")
    );
  }
}
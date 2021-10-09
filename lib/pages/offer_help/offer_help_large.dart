import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/subject.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/widgets/custom_dropdown_button.dart';
import 'package:inno_tutor/widgets/page_cap.dart';

class OfferHelpLargePage extends StatefulWidget {
  const OfferHelpLargePage({ Key key }) : super(key: key);

  @override
  _OfferHelpLargePageState createState() => _OfferHelpLargePageState();
}

class _OfferHelpLargePageState extends State<OfferHelpLargePage> {
  List<String> subjects; 

  @override
  initState() {
    super.initState();
    fetch_subjects();
  }

  Future<void> fetch_subjects() async {
    subjects = await Services().getSubjects();
    print(subjects);
  }
  
  Widget build(BuildContext context) {
    Card newCard = Card(0, 0, "", 0, "", [], [], false, 0);
    return Container(
      child: Column(
        children: [
          PageCap(text: "Offer Help"),
          Container(
            width: 610,
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.topLeft,
            child: CustomDropDownButton(locations: subjects, card: newCard)
          )
        ],
      )
    );
  }
}
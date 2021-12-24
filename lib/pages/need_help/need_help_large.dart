import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart' as style;
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/tutor.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/check_box_row.dart';
import 'package:inno_tutor/ui_widgets/search_tutor_card_widget.dart';
import 'package:inno_tutor/widgets/custom_dropdown_button.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:inno_tutor/widgets/page_cap.dart';
import 'package:inno_tutor/globals.dart' as globals;

class Pair<T1, T2> {
  final T1 user;
  final T2 tutor;

  Pair(this.user, this.tutor);
}

class NeedHelpLargePage extends StatefulWidget {
  const NeedHelpLargePage({ Key key }) : super(key: key);

  @override
  _NeedHelpLargePageState createState() => _NeedHelpLargePageState();
}

class _NeedHelpLargePageState extends State<NeedHelpLargePage> {
  List<String> subjects;
  bool subjects_fetched = false; 
  Card newCard = Card(0, 0, "", 0, "", [], [], false, 0);
  List<Pair<User, Tutor>> tutors;

  @override
  initState() {
    super.initState();
    fetch_subjects();
  }

  Future<void> fetch_subjects() async {
    tutors = [];
    await SearchServices().getTutors("", null, null, null);
    subjects = await Services().getSubjects();
    for (Tutor t in globals.allTutors){
      print(t.tutorId.toString());
      User user = await UserServices().getUser(t.tutorId.toString());
      tutors.add(Pair(user, t));
    }
    subjects = await Services().getSubjects();
    setState(() {
      subjects_fetched = true;
    });
    setState(() {
      subjects_fetched = true;
    });
  }

  bool updated = true;
  Future<void> updateResults(Card updatedCard) async{
    tutors = [];
    setState(() {
      updated = false;
    });
    for (Tutor t in globals.allTutors){
      print(t.tutorId.toString());
      User user = await UserServices().getUser(t.tutorId.toString());
      tutors.add(Pair(user, t));
    };
    await SearchServices().getTutors(updatedCard.subject, updatedCard.sessionFormat, updatedCard.sessionType, null);
    setState(() {
      updated = true;
    });
  }
  
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PageCap(text: "Need Help"),
          subjects_fetched ? Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15),
            alignment: Alignment.topLeft,
            child: CustomDropDownButton(locations: subjects, card: newCard, width: 700, updateResults: updateResults)
          ) : Wrap(),
          subjects_fetched ? Container(
            width: 610,
            padding: EdgeInsets.only(top: 10),
            child: CheckBoxRow(card: newCard, color: style.darkGrey, themeColor: style.darkGrey, updateResults: updateResults, radio: true)
          ) : Wrap(),
          subjects_fetched ? Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 15, top: 10),
            child: CustomText(
              text: "Results:",
              color: style.darkGrey,
              size: 18,
              weight: FontWeight.bold,
            )
          ) : Wrap(),
          subjects_fetched && updated ? Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: tutors != [] ? Column(
                mainAxisSize: MainAxisSize.min,
                children: 
                tutors.map((item) => SearchTutorCardWidget(tutor: item.tutor, user: item.user)).toList()
              ) : 
              Container(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(
                  backgroundColor: style.grey,
                  valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
                ),
            ),
          ) : Container(
            padding: EdgeInsets.all(10),
            child: CircularProgressIndicator(
                backgroundColor: style.grey,
                valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
              ),
          ),
          Container(
            height: 10,
          )
        ],
      )
    );
  }
}
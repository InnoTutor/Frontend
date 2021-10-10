import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart' as style;
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/student_request.dart';
import 'package:inno_tutor/models/subject.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/check_box_row.dart';
import 'package:inno_tutor/ui_widgets/cv_card_widget.dart';
import 'package:inno_tutor/ui_widgets/search_student_card_widget.dart';
import 'package:inno_tutor/ui_widgets/student_card_widget.dart';
import 'package:inno_tutor/ui_widgets/search_tutor_card_widget.dart';
import 'package:inno_tutor/widgets/custom_dropdown_button.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:inno_tutor/widgets/page_cap.dart';
import 'package:inno_tutor/globals.dart' as globals;

class Pair<T1, T2> {
  final T1 user;
  final T2 studentRequest;

  Pair(this.user, this.studentRequest);
}


class OfferHelpLargePage extends StatefulWidget {
  const OfferHelpLargePage({ Key key }) : super(key: key);

  @override
  _OfferHelpLargePageState createState() => _OfferHelpLargePageState();
}

class _OfferHelpLargePageState extends State<OfferHelpLargePage> {
  List<String> subjects;
  bool subjects_fetched = false; 
  Card newCard = Card(0, 0, "", 0, "", [], [], false, 0);
  List<Pair<User, StudentRequest>> students;

  @override
  initState() {
    super.initState();
    fetch_subjects();
  }

  Future<void> fetch_subjects() async {
    students = [];
    await SearchServices().getStudents("", [], []);
    for (StudentRequest sq in globals.allStudents){
      print(sq.studentId.toString());
      User user = await UserServices().getUser(sq.studentId.toString());
      students.add(Pair(user, sq));
    }
    subjects = await Services().getSubjects();
    setState(() {
      subjects_fetched = true;
    });
  }
  
  bool updated = true;
  Future<void> updateResults(Card updatedCard) async{
    students = [];
    setState(() {
      updated = false;
    });
    await SearchServices().getStudents(updatedCard.subject, updatedCard.sessionFormat, updatedCard.sessionType);
    for (StudentRequest sq in globals.allStudents){
      print(sq.studentId.toString());
      User user = await UserServices().getUser(sq.studentId.toString());
      students.add(Pair(user, sq));
    };
    setState(() {
      updated = true;
    });

  }
  
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PageCap(text: "Offer Help"),
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
          ): Wrap(),
          subjects_fetched && updated ? Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: students!=[] ? Column(
                mainAxisSize: MainAxisSize.min,
                children: 
                students.map((item) => SearchStudentCardWidget(studentRequest: item.studentRequest, user: item.user,)).toList()
              ) : 
              Container(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(
                  backgroundColor: style.grey,
                  valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
                ),
            ),
          ) : Wrap(),
          Container(
            height: 10,
          )
        ],
      )
    );
  }
}
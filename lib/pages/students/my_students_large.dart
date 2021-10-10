import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/requested_students.dart';
import 'package:inno_tutor/models/subject.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/check_box_row.dart';
import 'package:inno_tutor/ui_widgets/cv_card_widget.dart';
import 'package:inno_tutor/ui_widgets/editable_cv_card_widget.dart';
import 'package:inno_tutor/ui_widgets/student_card_widget.dart';
import 'package:inno_tutor/widgets/custom_dropdown_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:inno_tutor/services/database.dart';
import '../../constants/style.dart' as style;
import '../../widgets/custom_text.dart';
import '../../widgets/page_cap.dart';
import 'package:inno_tutor/globals.dart' as globals;

class MyStudentsLargePage extends StatefulWidget {
  @override
  _MyStudentsLargeState createState() => _MyStudentsLargeState();
}

class _MyStudentsLargeState extends State<MyStudentsLargePage> {
  List<Card> myStudentsCards = [];
  @override
  initState() {
    super.initState();
    fetch_cards('');
  }

  bool students_fetched = false;

  Future<List<Enrollment>> fetch_cards(String search) async {
    MyStudentsModel myStudentsModel = await new MyStudentsServices().getStudents();
    globals.myStudents = myStudentsModel.acceptedStudentsList;
    for (Enrollment en in globals.myStudents){
      Card studentCard = await CardServices().getCvCard(en.cardId);
      print(studentCard.cardId);
      myStudentsCards.add(studentCard);
    }
    if (mounted) {
      setState(() {
      });
    }
    setState(() {
      students_fetched = true;
      print(myStudentsCards);
    });
    return globals.myStudents;
  }

  void update(){
    if(mounted)
      setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PageCap(text: "My Students"),
      students_fetched ? Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: students_fetched ? Column(
            mainAxisSize: MainAxisSize.min,
            children: myStudentsCards
                .map((item) => StudentCardWidget(card: item))
                .toList()) :
                Container(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                      backgroundColor: style.grey,
                      valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
                    ),
                ),
      ) : Wrap(),
    ]);
  }
}

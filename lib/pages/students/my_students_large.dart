import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/requested_students.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/student_card_widget.dart';
// import 'package:inno_tutor/services/database.dart';
import '../../constants/style.dart' as style;
import '../../widgets/custom_text.dart';
import '../../widgets/page_cap.dart';
import 'package:inno_tutor/globals.dart' as globals;

class Triple<T1, T2, T3> {
  final T1 user;
  final T2 enrollmentCard;
  final T3 enrollment;

  Triple(this.user, this.enrollmentCard, this.enrollment);
}

class MyStudentsLargePage extends StatefulWidget {
  @override
  _MyStudentsLargeState createState() => _MyStudentsLargeState();
}

class _MyStudentsLargeState extends State<MyStudentsLargePage> {
  List<Triple<User, Card, Enrollment>> myNewStudents;
  List<Triple<User, Card, Enrollment>> myAcceptedStudents;
  @override
  initState() {
    super.initState();
    fetch_cards('');
  }

  bool students_fetched = false;

  Future<List<Enrollment>> fetch_cards(String search) async {
    myNewStudents = [];
    myAcceptedStudents = [];
    
    MyStudentsModel myStudentsModel = await new MyStudentsServices().getStudents();

    globals.myNewStudents = myStudentsModel.newStudents;
    for (Enrollment en in globals.myNewStudents){
      User student = await UserServices().getUser(en.enrollerId.toString());
      Card enrollmentCard = await CardServices().getCvCard(en.cardId);
      myNewStudents.add(Triple(student, enrollmentCard, en));
    }

    globals.myAcceptedStudents = myStudentsModel.acceptedStudents;
    for (Enrollment en in globals.myAcceptedStudents){
      User student = await UserServices().getUser(en.enrollerId.toString());
      Card enrollmentCard = await CardServices().getCvCard(en.cardId);
      myAcceptedStudents.add(Triple(student, enrollmentCard, en));
    }

    setState(() {
      students_fetched = true;
    });
    return globals.myNewStudents;
  }

  void update(){
    setState(() {
      students_fetched = false;
    });
    fetch_cards('');
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PageCap(text: "My Students"),
      students_fetched && myNewStudents.length != 0 ? 
      Container(
        margin: EdgeInsets.only(top: 15, left:10, right:10, bottom: 5),
        decoration: BoxDecoration(
          color :style.lightGrey,
          borderRadius:  BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, top: 10),
              child: CustomText(text: "New Students (" + myNewStudents.length.toString() + "):", size: 18, weight: FontWeight.bold,)
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: students_fetched ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: myNewStudents
                      .map((item) => StudentCardWidget(student: item.user, enrollmentCard: item.enrollmentCard, enrollment: item.enrollment, isNew: true, update: update))
                      .toList()) :
                      Container(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                            backgroundColor: style.grey,
                            valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
                          ),
                      ),
            ),
          ],
        ),
      ) : Wrap(),
      students_fetched && globals.myAcceptedStudents.length != 0 ? 
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: students_fetched ? Column(
          mainAxisSize: MainAxisSize.min,
          children: myAcceptedStudents
              .map((item) => StudentCardWidget(student: item.user, enrollmentCard: item.enrollmentCard, enrollment: item.enrollment, isNew: false, update: update,))
              .toList()) :
              Container(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(
                    backgroundColor: style.grey,
                    valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
                ),
              ),
      ) : Wrap(),
      !students_fetched ?
      Container(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(
            backgroundColor: style.grey,
            valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
          ),
      ) : Wrap(),
    ]);
  }
}

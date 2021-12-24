import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:inno_tutor/constants/ui_constants.dart';
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

class MyStudentsLargePage extends StatefulWidget {
  @override
  _MyStudentsLargeState createState() => _MyStudentsLargeState();
}

class _MyStudentsLargeState extends State<MyStudentsLargePage> {
  @override
  initState() {
    super.initState();
    fetch_cards('');
  }

  bool fetch_required = true;

  Future<List<Enrollment>> fetch_cards(String search) async {
    MyStudentsModel myStudentsModel = await new MyStudentsServices().getStudents();

    globals.myNewStudents = myStudentsModel.newStudents;
    globals.myAcceptedStudents = myStudentsModel.acceptedStudents;

    setState(() {
      fetch_required = false;
    });
    return globals.myNewStudents;
  }

  void update(){
    setState(() {
      fetch_required = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PageCap(text: "My Students"),
      !fetch_required && globals.myNewStudents.length != 0 ? 
      Container(
        margin: EdgeInsets.only(top: 15, left:10, right:10),
        decoration: commonHiddenCardDecoration,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, top: 10),
              child: CustomText(text: "New Students (" + globals.myNewStudents.length.toString() + "):", size: 18, weight: FontWeight.bold, color: style.darkGrey)
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: !fetch_required ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: globals.myNewStudents
                      .map((item) => StudentCardWidget(enrollment: item, isNew: true, update: update))
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
      !fetch_required && globals.myAcceptedStudents.length != 0 ? 
      Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: !fetch_required ? Column(
          mainAxisSize: MainAxisSize.min,
          children: globals.myAcceptedStudents
              .map((item) => StudentCardWidget(enrollment: item, isNew: false, update: update,))
              .toList()) :
              Container(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(
                    backgroundColor: style.grey,
                    valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
                ),
              ),
      ) : Wrap(),
      fetch_required ?
      Container(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(
            backgroundColor: style.grey,
            valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
          ),
      ) : Wrap(),
      Container(
        height: 20,
      )
    ]);
  }
}

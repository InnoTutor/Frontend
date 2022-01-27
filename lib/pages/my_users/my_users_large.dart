import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:inno_tutor/constants/style.dart';
import 'package:inno_tutor/constants/ui_constants.dart';
import 'package:inno_tutor/models/accept_models/accept_model.dart';
import 'package:inno_tutor/models/responded_users/requested_students.dart';
import 'package:inno_tutor/models/responded_users/responded_tutors.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/my_user_widgets/my_user_widget.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:inno_tutor/widgets/page_cap.dart';

// ignore: must_be_immutable
class MyUsersLargePage extends StatefulWidget {
  bool myStudentsPage = false;
  bool myTutorsPage = false;

  MyUsersLargePage({this.myStudentsPage = false, this.myTutorsPage = false, Key key});

  @override
  _MyUsersLargeState createState() => _MyUsersLargeState();
}

class _MyUsersLargeState extends State<MyUsersLargePage> {
  List<AcceptModel> myNewUsers;
  List<AcceptModel> myAcceptedUsers;

  @override
  initState() {
    super.initState();
    fetch_cards('');
  }

  bool fetch_required = true;

  Future<void> fetch_cards(String search) async {
    print("before");
    if (widget.myTutorsPage){
      MyTutorsModel myTutorsModel = await new MyTutorsServices().getTutors();
      myNewUsers = myTutorsModel.newTutors;
      myAcceptedUsers = myTutorsModel.acceptedTutors;
    }
    print("after");
    if (widget.myStudentsPage){
      MyStudentsModel myStudentsModel = await new MyStudentsServices().getStudents();
      myNewUsers = myStudentsModel.newStudents;
      myAcceptedUsers = myStudentsModel.acceptedStudents;
    }

    print(myNewUsers.length);
    print(myAcceptedUsers.length);

    setState(() {
      fetch_required = false;
    });
  }

  void update(String code, {AcceptModel user}){
    switch (code){
      case "approve":
        setState(() {
          myNewUsers.remove(user);
          myAcceptedUsers.add(user);
          print(user.name);
          print(user.surname);
          print(user.subject);
        });
        break;
      case "remove":
        setState(() {
          myNewUsers.remove(user);
          myAcceptedUsers.remove(user);
        });
        break;
    };
    setState(() {
      fetch_required = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PageCap(text: widget.myStudentsPage ? "My Students" : widget.myTutorsPage ? "My Tutors" : ""),
      !fetch_required && myNewUsers.length != 0 ? 
      Container(
        margin: EdgeInsets.only(top: 15, left:10, right:10),
        decoration: commonHiddenCardDecoration,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, top: 10),
              child: CustomText(
                text: (widget.myStudentsPage ? "New Students (" : widget.myTutorsPage ? "New Tutors (" : "") + myNewUsers.length.toString() + "):", 
                size: 18, 
                weight: FontWeight.bold, 
                color: darkGrey)
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: !fetch_required ? Column(
                mainAxisSize: MainAxisSize.min,
                children: myNewUsers
                  .map((item) => 
                    MyUserWidget(user: item, isNew: true, update: update)
                  )
                  .toList()) :
                  Container(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      backgroundColor: grey,
                      valueColor: new AlwaysStoppedAnimation<Color>(lightGrey),
                    ),
                  ),
            ),
          ],
        ),
      ) : Wrap(),
      !fetch_required && myAcceptedUsers.length != 0 ? 
      Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: !fetch_required ? Column(
          mainAxisSize: MainAxisSize.min,
          children: myAcceptedUsers
              .map((item) => MyUserWidget(user: item, isNew: false, update: update,))
              .toList()) :
              Container(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(
                    backgroundColor: grey,
                    valueColor: new AlwaysStoppedAnimation<Color>(lightGrey),
                ),
              ),
      ) : Wrap(),
      fetch_required ?
      Container(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(
            backgroundColor: grey,
            valueColor: new AlwaysStoppedAnimation<Color>(lightGrey),
          ),
      ) : Wrap(),
      Container(
        height: 20,
      )
    ]);
  }
}

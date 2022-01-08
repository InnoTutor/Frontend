import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart';
import 'package:inno_tutor/models/my_student.dart';
import 'package:inno_tutor/models/request_models/student_request.dart';
import 'package:inno_tutor/models/request_models/tutor.dart';

import 'models/card.dart';
import 'models/user.dart';

User user;

List<Card> myCards ;
List<Tutor> allTutors;
List<Tutor> filteredTutors;
List<StudentRequest> allStudents;
List<StudentRequest> filteredStudents;
List<MyStudent> myNewStudents;
List<MyStudent> myAcceptedStudents;
Map <int , Icon> icons = {0:Icon(Icons.done, color: almostDarkGrey) , 1 : Icon(Icons.create_rounded, color: almostDarkGrey)};
List<String>formats=[];
List<String>types=[];

Card getCardById(int cardId){
  for (Card c in myCards){
    if (c.cardId == cardId){
      return c;
    }
  }
  return null;
}

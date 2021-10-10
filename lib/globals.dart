import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/requested_students.dart';
import 'package:inno_tutor/models/student_request.dart';
import 'package:inno_tutor/models/tutor.dart';
import 'package:inno_tutor/pages/students/my_students.dart';

import 'models/card.dart';
import 'models/user.dart';

User user;

List<Card> myCards ;
List<Tutor> allTutors;
List<StudentRequest> allStudents;
List<Enrollment> myNewStudents;
List<Enrollment> myAcceptedStudents;
Map <int , Icon> icons = {0:Icon(Icons.done, color: Colors.white) , 1 : Icon(Icons.create_rounded, color: Colors.white)};
List<String>formats=[];
List<String>types=[];


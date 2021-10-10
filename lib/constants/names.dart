import 'package:flutter/material.dart';
import 'package:inno_tutor/pages/profile/my_profile.dart';
import 'package:inno_tutor/pages/requests/my_requests.dart';
import 'package:inno_tutor/pages/schedules/my_schedules.dart';
import 'package:inno_tutor/pages/services/my_serviecs.dart';
import 'package:inno_tutor/pages/students/my_students.dart';

List<String> title = ['My Profile','My Services','My Students','My Schedule', 'My Requests'];
List<String> routNames = ['/profile','/services','/students','/schedule', '/requests'];
List<Widget> names = [
  MyProfile(),
  MyServices(),
  MyStudents(),
  MySchedules(),
  MyRequests()
];
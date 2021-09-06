import 'package:flutter/material.dart';
import 'package:inno_tutor_flutter/pages/my_profile/my_profile.dart';
import 'package:inno_tutor_flutter/pages/my_requests/my_requests.dart';
import 'package:inno_tutor_flutter/pages/my_schedule/my_schedule.dart';
import 'package:inno_tutor_flutter/pages/my_services/my_services.dart';
import 'package:inno_tutor_flutter/pages/my_students/my_students.dart';
import 'package:inno_tutor_flutter/routing/routs.dart';

Route<dynamic> generateRoute(RouteSettings settings){
switch(settings.name){
  case MyProfilePageRout:
      return _getPageRout(MyProfilePage());
    case MyStudentsPageRout:
      return _getPageRout(MyStudentsPage());
    case MySchedulePageRout:
      return _getPageRout(MySchedulePage());
    case MyRequestsPageRout:
      return _getPageRout(MyRequestsPage());
    case MyServicesPageRout:
      return _getPageRout(MyServicesPage());
    return _getPageRout(MyProfilePage());
  }
}


PageRoute _getPageRout(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}
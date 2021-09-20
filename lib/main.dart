import 'package:flutter/material.dart';
import 'package:inno_tutor/layout.dart';

import 'elements/drawer.dart';
import 'pages/profile/my_profile.dart';
import 'pages/requests/my_requests.dart';
import 'pages/schedules/my_schedules.dart';
import 'pages/services/my_serviecs.dart';
import 'pages/students/my_students.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
      ),
      routes: {
        // '/': (BuildContext context) => SiteLayout(page: MyProfile()),
        '/services': (BuildContext context) => SiteLayout(page: MyServices()),
        '/profile': (BuildContext context) => SiteLayout(page: MyProfile()),
        '/students': (BuildContext context)=> SiteLayout(page: MyStudents()),
        '/schedule': (BuildContext context)=> SiteLayout(page: MySchedules()),
        '/requests': (BuildContext context)=> SiteLayout(page: MyRequests()),
      },
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      home: SiteLayout(page: MyProfile(),),
    );
  }
}
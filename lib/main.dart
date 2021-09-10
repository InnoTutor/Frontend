import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {'My Services': (BuildContext context) => MyServices(),
        'My Profile': (BuildContext context) => MyProfile(),
        'My Students': (BuildContext context)=> MyStudents(),
        'My Schedule': (BuildContext context)=> MySchedules(),
        'My Requests': (BuildContext context)=> MyRequests(),
      },

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       drawer: AppDrawer(),
       body: MyProfile(),
    );
  }
}

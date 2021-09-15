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
      routes: {
        '/': (BuildContext context) => MyHomePage(),
        '/services': (BuildContext context) => MyServices(),
        '/profile': (BuildContext context) => MyProfile(),
        '/students': (BuildContext context)=> MyStudents(),
        '/schedule': (BuildContext context)=> MySchedules(),
        '/requests': (BuildContext context)=> MyRequests(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

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

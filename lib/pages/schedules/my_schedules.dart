import 'package:flutter/material.dart';
import 'package:inno_tutor/elements/drawer.dart';

class MySchedules extends StatefulWidget {
  @override
  _MySchedulesState createState() => _MySchedulesState();
}

class _MySchedulesState extends State<MySchedules> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inno Tutor'),
      ),
      drawer: AppDrawer(),
      body: Text('My Schedules'),);
  }
}

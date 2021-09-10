import 'package:flutter/material.dart';
import 'package:inno_tutor/elements/drawer.dart';

class MyStudents extends StatefulWidget {
  @override
  _MyStudentsState createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inno Tutor'),
      ),
      drawer: AppDrawer(),
      body: Text('My Students'),);
  }
}

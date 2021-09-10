import 'package:flutter/material.dart';
import 'package:inno_tutor/elements/drawer.dart';

class MyRequests extends StatefulWidget {
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inno Tutor'),
      ),
      drawer: AppDrawer(),
      body: Text('My Requests'),);
  }
}
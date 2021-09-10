import 'package:flutter/material.dart';
import 'package:inno_tutor/elements/drawer.dart';

class MyServices extends StatefulWidget {
  @override
  _MyServicesState createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inno Tutor'),
      ),
      drawer: AppDrawer(),
      body: Text('My Services'),);
  }
}

import 'package:flutter/material.dart';
import 'package:inno_tutor/elements/drawer.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inno Tutor'),
        ),
      drawer: AppDrawer(),

      body: Text('My Profile'),);
  }
}

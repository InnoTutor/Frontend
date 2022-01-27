import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/widgets.dart';
import 'package:inno_tutor/pages/my_users/my_users_large.dart';


class MyTutorsLargePage extends StatefulWidget {
  @override
  _MyTutorsLargeState createState() => _MyTutorsLargeState();
}

class _MyTutorsLargeState extends State<MyTutorsLargePage> {
  
  @override
  Widget build(BuildContext context) {
    return MyUsersLargePage(myTutorsPage: true);
  }
}

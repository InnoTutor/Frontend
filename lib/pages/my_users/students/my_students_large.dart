import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/widgets.dart';
import 'package:inno_tutor/pages/my_users/my_users_large.dart';


class MyStudentsLargePage extends StatefulWidget {
  @override
  _MyStudentsLargeState createState() => _MyStudentsLargeState();
}

class _MyStudentsLargeState extends State<MyStudentsLargePage> {
  
  @override
  Widget build(BuildContext context) {
    return MyUsersLargePage(myStudentsPage: true);
  }
}

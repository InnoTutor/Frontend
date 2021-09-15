import 'package:flutter/material.dart';
import 'package:inno_tutor/database/global_funtions.dart';
import 'package:inno_tutor/elements/drawer.dart';

class MyRequests extends StatefulWidget {
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final arguments = ModalRoute.of(context)!.settings.arguments;
        List<String>list = handle_arguments(arguments);
        Navigator.pushReplacementNamed(context,'/'+list[0] , arguments: {'route':list[1]} );



          return true;
        },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inno Tutor'),
        ),
        drawer: AppDrawer(),
        body: Text('My Requests'),),
    );
  }
}

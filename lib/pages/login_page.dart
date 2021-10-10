import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:inno_tutor/services/global_funtions.dart';
import 'package:inno_tutor/elements/drawer.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';
import 'package:inno_tutor/pages/profile/my_profile.dart';
import 'package:inno_tutor/services/auth.dart';
import 'package:inno_tutor/services/global_funtions.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:inno_tutor/widgets/page_cap.dart';
import 'package:inno_tutor/constants/style.dart' as style;
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    Firebase.initializeApp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final arguments = ModalRoute.of(context).settings.arguments;
        List<String>list = handle_arguments(arguments);
        Navigator.pushReplacementNamed(context,'/'+list[0] , arguments: {'route':list[1]} );
        return true;
      },
      child: MyProfile(),
    );
  }
}

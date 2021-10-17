import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:inno_tutor/globals.dart' as globals;
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/global_funtions.dart';
import 'package:inno_tutor/pages/profile/my_profile.dart';
import 'package:inno_tutor/services/auth.dart';
import 'package:inno_tutor/constants/style.dart' as style;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  bool login = false;
  bool clicked = false;
  final Function() notifyParent;
  Login({Key key, @required this.notifyParent}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
    fetch();
  }

  fetch() async {
    String token = await AuthService().extractToken();

    if (globals.user == null && token != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String user = prefs.getString('user');
      List<String> cards = prefs.getStringList('my_cards');
      if (user != null) {
        widget.login=true;
        globals.user = User.fromJson(json.decode(user));
        if (mounted) {
          setState(() {});
        }
      }
      if (cards != null) {
        globals.myCards =
            cards.map((e) => Card.fromJson(json.decode(e))).toList();
        print(globals.myCards.map((e) => e.toJson()));
        if (mounted) {
          setState(() {});
        }
      }
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.login == false ? WillPopScope (
      onWillPop: () async{
        final arguments = ModalRoute.of(context).settings.arguments;
        List<String>list = handle_arguments(arguments);
        Navigator.pushReplacementNamed(context,'/'+list[0] , arguments: {'route':list[1]} );
        return true;
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(15),
        child: Wrap(
          children: [
            widget.clicked == false ? SignInButton(
            Buttons.Google,
            text: "Sign up with Google",
            onPressed: () async {
              if(mounted)
              setState(() {
                widget.clicked=true;
      
              });
              AuthService auth_service =
                  new AuthService();
              await auth_service
                  .signInWithGoogle()
                  .then((result) {})
                  .catchError((error) {
                print(
                    'Registration Error: $error');
              });
              if(mounted)
              setState(() {
                widget.login=true;
                widget.notifyParent();
              });
            },
          ):CircularProgressIndicator(
            backgroundColor: style.grey,
            valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
          ),
          ]
      ),
      )
    ) : MyProfile();
  }
}

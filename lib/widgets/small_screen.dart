import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:inno_tutor/models/user.dart';

import 'package:inno_tutor/pages/profile/my_profile.dart';
import 'package:inno_tutor/services/auth.dart';
import 'package:inno_tutor/widgets/top_nav.dart';
import '../constants/style.dart' as style;
import '../layout.dart';

class SmallScreen extends StatefulWidget {
  final Widget page;
  bool login;
  User user;
  SmallScreen({ Key key, this.page, this.login, this.user}) : super(key: key);

  @override
  _SmallScreenState createState() => _SmallScreenState();
}

class _SmallScreenState extends State<SmallScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthService().getUserData() != null ? Container(
        constraints: BoxConstraints.expand(),
        color: style.lightGrey,
        child: widget.page
     ) :
    Container(
      color: style.lightGrey,
      alignment: Alignment.center,
      child: SizedBox(
        height: 50,
        width: 300,
        child:SignInButton(
          Buttons.Google,
          text: "Sign up with Google",
          onPressed: () async {
      setState(() {
        widget.login = true;
      });
      AuthService auth_service = new AuthService();
      await auth_service.signInWithGoogle().then((result) {
        print(result);
      }).catchError((error) {
        print('Registration Error: $error');
      });
      setState(() {
        widget.login = false;
      });

          },

        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:inno_tutor/constants/style.dart' as style;
import 'package:inno_tutor/widgets/top_nav.dart';

class SmallScreen extends StatelessWidget {
  final Widget page;
  bool login;
  SmallScreen({ Key key, this.page, this.login}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !login ? Container(
      constraints: BoxConstraints.expand(),
      color: style.lightGrey,
      child: page
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
          onPressed: () {}
        )
      )
    );
  }
}
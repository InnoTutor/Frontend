import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:inno_tutor/services/auth.dart';
import '../constants/style.dart' as style;
import 'package:inno_tutor/globals.dart' as globals;

class SmallScreen extends StatefulWidget {
  final Widget page;
  SmallScreen({ Key key, this.page}) : super(key: key);

  @override
  _SmallScreenState createState() => _SmallScreenState();
}

class _SmallScreenState extends State<SmallScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }
  fetch()async{

    if(mounted){
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return globals.user!=null? Container(
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
      AuthService auth_service = new AuthService();
      await auth_service.signInWithGoogle().then((result) {
      }).catchError((error) {
        print('Registration Error: $error');
      });
      if(mounted)
        setState(() {
      });

          },

        ),
      ),
    );
  }
}

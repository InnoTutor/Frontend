import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:inno_tutor/elements/side_menu.dart';

import 'package:inno_tutor/services/auth.dart';
import '../constants/style.dart' as style;
import '../helpers/responsiveness.dart';
import '../layout.dart';
import 'package:inno_tutor/globals.dart' as globals;

class LargeScreen extends StatefulWidget {
  Widget page;
  bool login = false;
  SiteLayout layout;
  Function updPage;
  void Function() onTap;
  LargeScreen({ Key key , this.onTap, this.page, this.login, this.layout, this.updPage}) : super(key: key);

  @override
  _LargeScreenState createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  void updatePage(Widget nextPage) {
    setState(() {
      widget.page = nextPage;
    });
  }
  @override
  void initState() {
    super.initState();
    fetch();
  }
  fetch()async{
    if(globals.user == null)
      globals.user = await AuthService().getUserData();
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    String route = '';
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      globals.user != null ? Expanded(
                          child: Container(
                              color: style.lightGrey,
                              child: Container(
                                  width: 700,
                                  color: style.lightGrey,
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      child: Container(
                                          width: 230,
                                          height: ResponsiveWidget.isCustomSize(
                                              context) ? 520 : 300,
                                          margin: const EdgeInsets.only(
                                              right: 5, left: 10, top: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.03),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                )
                                              ]
                                          ),
                                          child: SideMenu(updPage: updatePage,)
                                      )
                                  )
                              )
                          )
                      ) : Expanded(child: Container(color: style.lightGrey)),
                      Container(
                          alignment: globals.user != null
                              ? Alignment.center
                              : Alignment.topCenter,
                          child: Column(
                            children: [
                              Container(
                                  width: globals.user != null
                                      ? 700
                                      : 300,
                                  color: style.lightGrey,
                                  alignment: globals.user != null
                                      ? Alignment.center
                                      : Alignment.topCenter,
                                  child: SizedBox(
                                      child: Container(
                                        //height: widget.login ? 70 : 500,
                                        margin: const EdgeInsets.only(
                                            right: 5, left: 5, top: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    0.03),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                              )
                                            ]
                                        ),
                                        child: globals.user != null ? widget.page :
                                        Container(
                                            padding: EdgeInsets.all(15),
                                            child: SignInButton(
                                              Buttons.Google,
                                              text: "Sign up with Google",
                                              onPressed: () async {
                                                if(mounted){
                                                  setState(() {
                                                    widget.login = false;
                                                  });
                                                }
                                                AuthService auth_service = new AuthService();
                                                await auth_service
                                                    .signInWithGoogle().then((result) {

                                                  print(result);
                                                }).catchError((error) {
                                                  print(
                                                      'Registration Error: $error');
                                                });
                                                if(mounted){
                                                  setState(() {
                                                    widget.login = true;
                                                  });
                                                }
                                              },
                                            )
                                        ),
                                      )
                                  )
                              ),
                              globals.user != null?
                              Expanded(
                                  child: Container(
                                      height: 50,
                                      width: 700,
                                      color: style.lightGrey
                                  )
                              )
                                  : Wrap()
                            ],
                          )
                      ),
                      Expanded(
                          child: Container(
                              width: 150,
                              color: style.lightGrey
                          )
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
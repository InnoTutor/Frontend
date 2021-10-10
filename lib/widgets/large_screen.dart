import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/rendering.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:inno_tutor/constants/controllers.dart';
import 'package:inno_tutor/elements/side_menu.dart';
import 'package:inno_tutor/globals.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/pages/need_help/need_help.dart';
import 'package:inno_tutor/pages/offer_help/offer_help.dart';
import 'package:inno_tutor/services/auth.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/style.dart' as style;
import '../helpers/responsiveness.dart';
import '../layout.dart';
import 'package:inno_tutor/globals.dart' as globals;
import 'package:inno_tutor/models/card.dart';

class LargeScreen extends StatefulWidget {
  Widget page;
  bool login = false;
  SiteLayout layout;
  Function updPage;
  void Function() onTap;
  final Function() notifyParent;
  bool clicked=false;
  LargeScreen(
      {Key key,
      this.onTap,
      @required this.notifyParent,
      this.page,
      this.login,
      this.layout,
      this.updPage})
      : super(key: key);

  @override
  _LargeScreenState createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  void updatePage(Widget nextPage) {
    if (mounted) {
      setState(() {
        widget.page = nextPage;
      });
    }
  }

  @override
  void initState() {
    widget.login = false;
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
    String route = '';
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  globals.user != null
                      ? Expanded(
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
                                                  context)
                                              ? 620
                                              : 360,
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
                                              ]),
                                          child: SideMenu(
                                            updPage: updatePage,
                                          ))))))
                      : Expanded(child: Container(color: style.lightGrey)),
                  Container(
                    color: style.lightGrey,
                      alignment: globals.user != null
                          ? Alignment.center
                          : Alignment.topCenter,
                      child: Column(
                        children: [
                          Container(
                              width: globals.user != null ? 700 : 300,
                              color: style.lightGrey,
                              alignment: globals.user != null
                                  ? Alignment.center
                                  : Alignment.topCenter,
                              child: SizedBox(
                                  child: Container(
                                      // height: widget.login ? 70 : 500,
                                      margin: const EdgeInsets.only(
                                          right: 5, left: 5, top: 10),
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
                                          ]),
                                      child: globals.user != null
                                          ? widget.page
                                          : Container(
                                              padding: EdgeInsets.all(15),
                                              child: widget.clicked==false?SignInButton(
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
                                      )
                                  )
                              )
                          ),
                          globals.user != null
                              ? Expanded(
                                  child: Container(
                                      height: 50,
                                      width: 700,
                                      color: style.lightGrey))
                              : Wrap()
                        ],
                      )),
                  Expanded(
                      child: Container(
                    color: style.lightGrey,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Visibility(
                            visible: globals.user == null ? false : true,
                            child: LayoutButton(
                              text: "Need Help",
                              updPage: updatePage,
                            )),
                        Visibility(
                            visible: globals.user == null ? false : true,
                            child: LayoutButton(
                              text: "Offer Help",
                              updPage: updatePage,
                            )),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class LayoutButton extends StatelessWidget {
  String text;
  Function updPage;
  LayoutButton({Key key, this.text, this.updPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 10),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
            backgroundColor: MaterialStateProperty.all(style.darkGreen),
          ),
          onPressed: () {
            for (Card card in myCards) {
              card.setEditable(false);
            }
            if (!menuController.isActive(text)) {
              menuController.changeActiveItemTo(text);
              updPage(text == "Need Help" ? NeedHelp() : OfferHelp());
              if (ResponsiveWidget.isSmallScreen(context)) Get.back();
            }
          },
          child: CustomText(
            text: text,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

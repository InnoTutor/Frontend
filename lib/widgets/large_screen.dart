import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:inno_tutor/elements/side_menu.dart';

import 'package:inno_tutor/services/auth.dart';
import '../constants/style.dart' as style;
import '../elements/drawer.dart';
import '../helpers/responsiveness.dart';
import '../layout.dart';
import '../pages/profile/my_profile.dart';
import '../pages/requests/my_requests.dart';
import '../pages/schedules/my_schedules.dart';
import '../pages/services/my_serviecs.dart';
import '../pages/students/my_students.dart';
import 'package:inno_tutor/models/user.dart';
class LargeScreen extends StatefulWidget {
  Widget page;
  bool login = false;
  SiteLayout layout;
  Function updPage;
  User user;
   void Function() onTap;
   LargeScreen({ Key key , this.onTap, this.page, this.login, this.layout, this.updPage, this.user}) : super(key: key);

  @override
  _LargeScreenState createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  bool user_is_null = true;
  User user = null;
  void updatePage(Widget nextPage) {
      setState(() {
        widget.page = nextPage;
      });
  }
  @override
  void initState() {
    fetch();
    super.initState();
  }
  fetch()async{
    user = await AuthService().getUserData();
      setState(() {
        user_is_null=false;
      });
  }


  @override
  Widget build(BuildContext context) {
    String route='';
      return user_is_null?Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: style.lightGrey,
                child: Container(
                  width: 700,
                  color: style.lightGrey,
                  alignment: Alignment.topRight,
                  child: Container(
                    child: Container(
                      width: 230,
                      height: ResponsiveWidget.isCustomSize(context) ? 520 : 300,
                      margin: const EdgeInsets.only(right:5, left:10, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.all(Radius.circular(10)),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
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
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    width: 700,
                    color: style.lightGrey,
                    alignment: Alignment.center,
                  child: SizedBox(
                    child: Container(
                      margin: const EdgeInsets.only(right:5, left:5, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.all(Radius.circular(10)),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            spreadRadius: 5,
                            blurRadius: 7,
                          )
                        ]
                      ),
                      child: widget.page
                    )
                  )
                ),
                Expanded(
                  child: Container(
                    width: 700,
                    color: style.lightGrey
                  )
                ) 
              ],
            )
          ),
          Expanded(
            child: Container(

              height: 2000,
              width: 150,
              color: style.lightGrey
            )
          ),
          ]
        )
      ): Scaffold(
        body: Container(
          color: style.lightGrey,
          child: SizedBox(
            child: Container(
              height: 70,
              width: 300,
              margin: const EdgeInsets.only(right:5, left:5, top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:  BorderRadius.all(Radius.circular(10)),
                boxShadow:[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    spreadRadius: 5,
                    blurRadius: 7,
                  )
                ]
              ),
              child: 
                Container(
                  padding: EdgeInsets.all(15),
                  child: SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () async {
                      AuthService auth_service = new AuthService();
                      await auth_service.signInWithGoogle().then((result) {
                        print(result);
                      }).catchError((error) {
                        print('Registration Error: $error');
                      });
                    },
                )
              ),
            )
          )
        )
      );
    }



    // return Scaffold(
    //   body: Row(
    //     children: [
    //        AuthService().getUserData() != null ? Expanded(
    //         child: Container(
    //           color: style.lightGrey,
    //           child: Container(
    //           width: 700,
    //           color: style.lightGrey,
    //           alignment: Alignment.topRight,
    //           child: Container(
    //             child: Container(
    //               width: 230,
    //               height: ResponsiveWidget.isCustomSize(context) ? 520 : 300,
    //               margin: const EdgeInsets.only(right:5, left:10, top: 10),
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius:  BorderRadius.all(Radius.circular(10)),
    //                 boxShadow:[
    //                   BoxShadow(
    //                     color: Colors.black.withOpacity(0.03),
    //                     spreadRadius: 5,
    //                     blurRadius: 7,
    //                   )
    //                 ]
    //               ),
    //               child: SideMenu(updPage: updatePage,)
    //             )
    //           )
    //         )
    //         )
    //       ) : Expanded(child: Container(color: style.lightGrey)),
    //       Container(
    //         alignment: AuthService().getUserData() != null ? Alignment.center : Alignment.topCenter,
    //         child: Column(
    //           children: [
    //             Container(
    //               width: AuthService().getUserData() != null  ? 700 : 300,
    //               color: style.lightGrey,
    //               alignment: AuthService().getUserData() != null ? Alignment.center : Alignment.topCenter,
    //               child: SizedBox(
    //                 child: Container(
    //                   //height: widget.login ? 70 : 500,
    //                   margin: const EdgeInsets.only(right:5, left:5, top: 10),
    //                   decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius:  BorderRadius.all(Radius.circular(10)),
    //                     boxShadow:[
    //                       BoxShadow(
    //                         color: Colors.black.withOpacity(0.03),
    //                         spreadRadius: 5,
    //                         blurRadius: 7,
    //                       )
    //                     ]
    //                   ),
    //                   child: AuthService().getUserData() != null ? widget.page :
    //                     Container(
    //                       padding: EdgeInsets.all(15),
    //                       child: SignInButton(
    //                         Buttons.Google,
    //                         text: "Sign up with Google",
    //                         onPressed: () async {
    //                           setState(() {
    //                             widget.login = false;
    //                           });
    //                           AuthService auth_service = new AuthService();
    //                           await auth_service.signInWithGoogle().then((result) {
    //                             print(result);
    //                           }).catchError((error) {
    //                             print('Registration Error: $error');
    //                           });
    //                           setState(() {
    //                             widget.login = true;
    //                           });
    //                         },
    //                     )
    //                   ),
    //                 )
    //               )
    //             ),
    //             AuthService().getUserData() != null ?
    //             Expanded(
    //               child: Container(
    //                 width: 700,
    //                 color: style.lightGrey
    //               )
    //             )
    //             : Wrap()
    //           ],
    //         )
    //       ),
    //       Expanded(
    //         child: Container(
    //
    //           height: 2000,
    //           width: 150,
    //           color: style.lightGrey
    //         )
    //       ),
    //     ],
    //   )
    // );
  // }
}
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
  get lightGrey => null;
  LargeScreen largeScreen;

  void updatePage(Widget nextPage) {
      setState(() {
        widget.page = nextPage;
      });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    List<String> title = ['My Profile','My Services','My Students','My Schedule', 'My Requests'];
    List<String> routNames = ['/profile','/services','/students','/schedule', '/requests'];
    List<Widget> names = [
      MyProfile(),
      MyServices(),
      MyStudents(),
      MySchedules(),
      MyRequests()
    ];    String route='';
    return Scaffold(
      body: Row(
        children: [
           AuthService().getUserData() != null ? Expanded(
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
          ) : Expanded(child: Container(color: style.lightGrey)),
          Container(
            child: Column(
              children: [
                Container(
                  width: AuthService().getUserData() != null ? 700 : 300,
                  color: style.lightGrey,
                  alignment: AuthService().getUserData() != null ? Alignment.topCenter : Alignment.center,
                  child: SizedBox(
                    child: Container(
                      //height: AuthService().getUserData() != null ? 600 : 70,
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
                      child: AuthService().getUserData() != null ? widget.page :
                        Container(
                          padding: EdgeInsets.all(15),
                          child: SignInButton(
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
                        )
                      ),
                    )
                  )
                ),
                AuthService().getUserData() != null ? Expanded(
                  child: Container(
                    width: 700,
                    color: style.lightGrey
                  )
                ) : null,
              ],
            )
          ),
          Expanded(
            child: Container(
              color: style.lightGrey
            )
          ),
        ],
      )
    );
  }
}
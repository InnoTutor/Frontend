import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inno_tutor/elements/side_menu.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/auth.dart' as auth;
import './elements/drawer.dart';
import './helpers/responsiveness.dart';
import './pages/profile/my_profile.dart';
import './pages/requests/my_requests.dart';
import './pages/schedules/my_schedules.dart';
import './pages/services/my_serviecs.dart';
import './pages/students/my_students.dart';
import './widgets/large_screen.dart';
import './widgets/small_screen.dart';
import './widgets/top_nav.dart';
class SiteLayout extends StatefulWidget {
   Widget page;
   bool login = false;
   User user;
   SiteLayout({Key key, this.page, this.login}) : super(key: key);

  @override
  _SiteLayoutState createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  @override
  void initState() {
    // TODO: implement initState
    Firebase.initializeApp();
    start();
    super.initState();
  }
  Future<void> start()async{

    await Firebase.initializeApp();
    await Future.delayed(const Duration(milliseconds: 500), () {});
    widget.user = await auth.AuthService().getUserData();
    if(widget.user!=null)
    setState((){
      widget.login = true;
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  List<String> title = [
    'My Profile',
    'My Services',
    'My Students',
    'My Schedule',
    'My Requests'
  ];
  List<Widget> names = [
    MyProfile(),
    MyServices(),
    MyStudents(),
    MySchedules(),
   MyRequests()
  ];
  String route = '';
  @override
  Widget build(BuildContext context) {

    print(ModalRoute.of(context).settings.name);
    return Scaffold(
        key: scaffoldKey,
        appBar: widget.login ? TopNavigationBar(context, scaffoldKey, true, null) :
                               TopNavigationBar(context, scaffoldKey, true, widget.user),
        body: ResponsiveWidget(
          largeScreen: LargeScreen(page: widget.page, login: widget.login, user: widget.user),
          mediumScreen: LargeScreen(page: widget.page, login: widget.login, user: widget.user),
          smallScreen: SmallScreen(page: widget.page, login: widget.login, user: widget.user),
        ),
        drawer: ResponsiveWidget.isSmallScreen(context) 
        // && !widget.login
            ?
            Drawer(child:SideMenu())
            : null);
  }
}

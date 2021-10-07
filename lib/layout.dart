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

  SiteLayout({Key key, this.page}) : super(key: key);

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

  Future<void> start() async {
    await Firebase.initializeApp();
    await Future.delayed(const Duration(milliseconds: 500), () {});

    if(mounted)
      setState(() {

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
        appBar: myAppBar(notifyParent: refresh,),
        body: ResponsiveWidget(
          largeScreen: LargeScreen(
              notifyParent: refresh,
              page: widget.page),
          mediumScreen: LargeScreen(
              notifyParent: refresh,
              page: widget.page),
          smallScreen: SmallScreen(
              page: widget.page),
        ),
        drawer: ResponsiveWidget.isSmallScreen(context)
            // && !widget.login
            ? Drawer(child: SideMenu())
            : null);
  }
  refresh() {
    setState(() {});
  }
}

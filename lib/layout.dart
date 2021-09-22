import 'package:flutter/material.dart';
import 'package:inno_tutor/elements/drawer.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';
import 'package:inno_tutor/pages/profile/my_profile.dart';
import 'package:inno_tutor/pages/requests/my_requests.dart';
import 'package:inno_tutor/pages/schedules/my_schedules.dart';
import 'package:inno_tutor/pages/services/my_serviecs.dart';
import 'package:inno_tutor/pages/students/my_students.dart';
import 'package:inno_tutor/widgets/large_screen.dart';
import 'package:inno_tutor/widgets/small_screen.dart';
import 'package:inno_tutor/widgets/top_nav.dart';
class SiteLayout extends StatefulWidget {
   Widget page;
   bool login = false;
   SiteLayout({Key key, this.page, this.login}) : super(key: key);

  @override
  _SiteLayoutState createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
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
        appBar: TopNavigationBar(context, scaffoldKey, true),
        body: ResponsiveWidget(
          largeScreen: LargeScreen(page: widget.page, login: widget.login),
          mediumScreen: LargeScreen(page: widget.page, login: widget.login),
          smallScreen: SmallScreen(page: widget.page, login: widget.login),
        ),
        drawer: ResponsiveWidget.isSmallScreen(context) && !widget.login
            ?
            // Drawer(child: SideMenu())
            Drawer(
                child: Stack(children: [
                  ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: names.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: Icon(Icons.list),
                                title: Text(title[index]),
                                onTap: () {
                                  print((ModalRoute.of(context).settings.name
                                          as String) +
                                      ' drawerrr');
                                  var arguments =
                                      ModalRoute.of(context).settings.arguments;
                                  String route = ModalRoute.of(context)
                                      .settings
                                      .name as String;
                                  if (arguments != null) {
                                    arguments = arguments as Map;
                                    route = route +
                                        (arguments as Map)["route"].toString();
                                    print(
                                        (arguments as Map)["route"].toString() +
                                            '   drawerrr');
                                  }
                                 setState(() {
                                   widget.page = names[index];
                                 });
                                },
                              ),
                            );
                          }),
                    ],
                  ),
                ]),
              )
            : null);
  }
}

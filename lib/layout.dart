import 'package:flutter/material.dart';
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
        appBar: TopNavigationBar(context, scaffoldKey),
        body: ResponsiveWidget(
          largeScreen: LargeScreen(page: widget.page),
          mediumScreen: LargeScreen(page: widget.page),
          smallScreen: SmallScreen(page: widget.page),
        ),
        drawer: ResponsiveWidget.isSmallScreen(context)
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
